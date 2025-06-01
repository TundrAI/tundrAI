# 👩‍💻 Development Guide

## Getting Started

### Prerequisites
- Docker & Docker Compose
- Git
- Node.js 18+ (for local development)
- pnpm (recommended package manager)

### Local Development Setup

1. **Clone all repositories**
   ```bash
   git clone https://github.com/TundrAI/tundrai-deploy.git
   git clone https://github.com/TundrAI/tundrai-frontend.git
   git clone https://github.com/TundrAI/tundrai-backend.git
   git clone https://github.com/TundrAI/tundrai-inference.git
   ```

2. **Setup environment**
   ```bash
   cd tundrai-backend
   cp .env.example .env
   # Edit .env with your values
   ```

3. **Start development environment**
   ```bash
   cd tundrai-backend
   pnpm run docker:dev
   ```

   This starts:
   - PostgreSQL (with both dev and test databases)
   - Redis
   - Qdrant
   - NestJS backend with hot reload

## Database Architecture

### Databases
- **tundrai_dev**: Development database (contains seeded admin user)
- **tundrai_test**: Test database (stays empty, cleaned during tests)

### User Entity
```typescript
User {
  id: UUID
  email: string (unique, lowercase)
  password: string (bcrypt hashed, never selected by default)
  role: enum (admin, user, uploader)
  firstName?: string
  lastName?: string
  isActive: boolean (default: true)
  emailVerified: boolean (default: false)
  lastLogin?: Date
  createdAt: Date
  updatedAt: Date
}
```

### Admin Seeding
On startup, the application automatically creates an admin user from environment variables:
- `ADMIN_EMAIL`
- `ADMIN_PASSWORD`
- `ADMIN_FIRST_NAME`
- `ADMIN_LAST_NAME`

## Database Migrations Workflow

### Overview
TundrAI uses a **dual approach** for database management:
- **Development**: `synchronize: true` - Auto-sync entities with database
- **Production**: `synchronize: false` - Migrations only

### Development Workflow

1. **During active development**:
   - TypeORM automatically syncs database with entity changes
   - No manual migrations needed
   - Fast iteration on database schema
   ```typescript
   // app.module.ts
   synchronize: configService.get('NODE_ENV') === 'development',
   ```

2. **When feature is complete**:
   ```bash
   # Generate migration from current entity state
   pnpm run migration:generate src/migrations/DescriptiveName
   
   # Example: After adding a new field to User entity
   pnpm run migration:generate src/migrations/AddUserPhoneNumber
   ```

3. **Testing migrations**:
   ```bash
   # Temporarily disable synchronize in app.module.ts
   # Run migrations to verify they work
   pnpm run migration:run
   
   # Check migration status
   pnpm run migration:show
   
   # If issues, revert and fix
   pnpm run migration:revert
   ```

### Production Workflow

1. **Pre-deployment checklist**:
   - All entity changes have corresponding migrations
   - Migrations tested locally
   - `synchronize: false` in production config

2. **Deployment process**:
   ```bash
   # Run pending migrations
   pnpm run migration:run
   
   # Verify all migrations applied
   pnpm run migration:show
   ```

### Migration Commands

```bash
# Generate migration from entity changes
pnpm run migration:generate src/migrations/DescriptiveName

# Create empty migration
pnpm run migration:create src/migrations/CustomMigration

# Run pending migrations
pnpm run migration:run

# Revert last migration
pnpm run migration:revert

# Show migration status
pnpm run migration:show
```

### Best Practices

1. **Naming conventions**:
   - Use descriptive names: `AddUserPhoneNumber`, `CreateConversationsTable`
   - Include ticket number if applicable: `TUND-123-AddUserRoles`

2. **Migration safety**:
   - Always review generated SQL before running
   - Test migrations on a copy of production data
   - Include both `up()` and `down()` methods
   - Never edit migrations after they've run in production

3. **Development tips**:
   - Keep `synchronize: true` during feature development
   - Generate migrations before PR review
   - Run migrations in CI/CD pipeline
   - Document breaking changes in migration files

4. **Common scenarios**:
   ```bash
   # After pulling changes with new migrations
   pnpm run migration:run
   
   # Reset development database
   docker exec -it tundrai-postgres psql -U tundrai -d tundrai_dev -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
   pnpm run migration:run
   ```

## Testing Infrastructure

### Test Database
- Separate PostgreSQL database: `tundrai_test`
- Automatically created on Docker startup
- Cleaned before each test run
- Uses `dropSchema: true` for fresh state

### Running Tests
```bash
# Run all tests
pnpm test

# Run tests with coverage
pnpm test:cov

# Run tests in watch mode
pnpm test:watch

# Run e2e tests
pnpm test:e2e
```

### Test Utilities
Located in `src/test/utils/`:
- `setupTestDatabase()`: Initialize test database connection
- `cleanTestDatabase()`: Clear all data between tests
- `teardownTestDatabase()`: Close connection after tests

### Coverage Requirements
- 100% coverage enforced
- Coverage reports in `coverage/` directory
- HTML report: `coverage/index.html`

## Development Workflow

Each service can be developed independently:
- **Frontend**: React development server with hot reload
- **Backend**: NestJS with auto-restart on changes
- **Inference**: Ollama with model management

### Backend Development

```bash
cd tundrai-backend

# Install dependencies
pnpm install

# Start development (with Docker services)
pnpm run docker:dev

# Run tests
pnpm test

# Run tests with coverage
pnpm test:cov

# Lint and format code
pnpm run lint
pnpm run format
```

## Code Standards

- TypeScript for all JavaScript code
- ESLint + Prettier for code formatting
- Conventional commits for git messages
- Jest for testing with 100% coverage requirement
- Pre-commit hooks with husky + lint-staged

### Commit Message Format
```
type(scope): description

feat(auth): add JWT refresh token support
fix(chat): resolve memory leak in conversation handler
docs(api): update authentication endpoints
test(users): add missing coverage for edge cases
```

### ESLint Configuration
- Airbnb-style rules
- TypeScript strict mode
- Explicit return types required
- Max complexity: 10
- Max lines per file: 300
- Max lines per function: 50

## Service Communication

Services communicate via:
- HTTP APIs (Frontend ↔ Backend)
- gRPC (Backend ↔ Inference)
- Vector database queries (Backend ↔ Qdrant)

### API Standards
- RESTful endpoints with `/api/v1` prefix
- JWT authentication for protected routes
- Consistent error response format
- Request/response validation with class-validator

## Environment Variables

### Required Variables
```env
# Application
NODE_ENV=development|production|test
PORT=3000

# Database
DB_HOST=localhost
DB_PORT=5432
DB_USERNAME=tundrai
DB_PASSWORD=your-password
DB_NAME=tundrai_dev
DB_NAME_TEST=tundrai_test

# Admin Seed
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=secure-password
ADMIN_FIRST_NAME=Admin
ADMIN_LAST_NAME=User

# JWT (for future use)
JWT_SECRET=your-secret
JWT_EXPIRATION=15m
```

### Docker Environment
When running in Docker, use service names:
- `DB_HOST=postgres` (not localhost)
- `REDIS_HOST=redis` (not localhost)
- `QDRANT_HOST=qdrant` (not localhost)
