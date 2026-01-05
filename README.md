# NestJS Boilerplate

A production-ready NestJS boilerplate with PostgreSQL, Prisma ORM, and Docker support. Built with Bun runtime for optimal performance.

## 🚀 Features

- **NestJS Framework** - Progressive Node.js framework for building efficient server-side applications
- **Bun Runtime** - Fast JavaScript runtime as a drop-in replacement for Node.js
- **Prisma ORM** - Next-generation ORM for type-safe database access
- **PostgreSQL** - Powerful, open-source relational database
- **Docker Support** - Multi-stage Dockerfile with development and production configurations
- **Code Quality** - Biome for linting and formatting
- **Validation** - Class-validator and class-transformer for request validation
- **Configuration** - Environment-based configuration with @nestjs/config

## 📋 Prerequisites

- [Bun](https://bun.sh/) >= 1.0.0
- [Docker](https://www.docker.com/) and Docker Compose (for containerized deployment)
- [PostgreSQL](https://www.postgresql.org/) >= 14 (if running locally without Docker)

## 🛠️ Installation

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/quangkhanhdev/nestjs-bun-boilerplate
   cd nestjs-bun-boilerplate
   ```

2. **Install dependencies**
   ```bash
   bun install
   ```

3. **Configure environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Update `.env` with your database credentials:
   ```env
   DATABASE_URL="postgresql://db_user:admin123@localhost:5432/nestjs_app?schema=test"
   ```

4. **Run database migrations**
   ```bash
   bun db:gen      # Generate Prisma Client
   bun db:deploy   # Run migrations
   ```

5. **Start the development server**
   ```bash
   bun start:dev
   ```

   The API will be available at `http://localhost:3000`

## 🐳 Docker Deployment

### Production

Build and run the production container:

```bash
docker-compose up --build
```

This will:
- Start PostgreSQL on port `5433` (host) → `5432` (container)
- Start NestJS application on port `3000`
- Automatically run Prisma migrations on startup

### Development with Docker

For development with hot-reload:

```bash
docker-compose -f docker-compose.dev.yaml up --build
```

### Stop containers

```bash
docker-compose down
```

### Clean up volumes

```bash
docker-compose down -v
```

## 📝 Available Scripts

| Script | Description |
|--------|-------------|
| `bun start` | Start the application |
| `bun start:dev` | Start in development mode with watch |
| `bun start:debug` | Start in debug mode |
| `bun start:prod` | Start production build |
| `bun build` | Build the application |
| `bun lint` | Run Biome linter |
| `bun format` | Format code with Biome |
| `bun db:gen` | Generate Prisma Client |
| `bun db:push` | Push schema changes to database |
| `bun db:deploy` | Deploy migrations to database |
| `bun db:studio` | Open Prisma Studio |

## 🗄️ Database

### Prisma Schema

The project uses Prisma with PostgreSQL. The schema is located in `prisma/schema.prisma`.

Example models:
- **User** - User entity with email and name
- **Post** - Blog post entity with title, content, and author relation

### Migrations

```bash
# Create a new migration
bunx prisma migrate dev --name migration_name

# Deploy migrations to production
bun db:deploy

# Reset database (development only)
bunx prisma migrate reset

# Open Prisma Studio
bun db:studio
```

## 🏗️ Project Structure

```
nestjs-boilerplate/
├── src/
│   ├── main.ts              # Application entry point
│   ├── app.module.ts        # Root module
│   ├── prisma/              # Prisma service
│   │   ├── prisma.module.ts
│   │   └── prisma.service.ts
│   └── user/                # User module (example)
│       ├── user.controller.ts
│       ├── user.service.ts
│       ├── user.module.ts
│       └── dto/
├── prisma/
│   ├── schema.prisma        # Database schema
│   └── migrations/          # Migration files
├── docker-compose.yaml      # Production Docker config
├── docker-compose.dev.yaml  # Development Docker config
├── Dockerfile               # Multi-stage Docker build
├── .dockerignore
├── biome.json               # Biome configuration
├── nest-cli.json            # NestJS CLI configuration
├── tsconfig.json            # TypeScript configuration
└── package.json
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# Database
DATABASE_URL="postgresql://db_user:admin123@localhost:5432/nestjs_app?schema=test"

# Application
NODE_ENV=development
PORT=3000
```

### Docker Configuration

The project includes two Docker Compose files:

- **docker-compose.yaml** - Production configuration
- **docker-compose.dev.yaml** - Development with hot-reload and debugging

## 📚 API Documentation

### Example Endpoints

#### Users

- `GET /users` - Get all users
- `GET /users/:id` - Get user by ID
- `POST /users` - Create a new user
- `PATCH /users/:id` - Update user
- `DELETE /users/:id` - Delete user

### Testing with REST Client extension

Use the `.http` files in the project for testing endpoints:

```http
### Get all users
GET http://localhost:3000/users

### Create user
POST http://localhost:3000/users
Content-Type: application/json

{
  "email": "user@example.com",
  "name": "John Doe"
}
```

## 🧪 Testing

```bash
# Unit tests
bun test

# E2E tests
bun test:e2e

# Test coverage
bun test:cov
```

## 🚢 Production Deployment

### Building for Production

```bash
# Build the application
bun build

# Run production server
bun start:prod
```

### Docker Production Build

The Dockerfile uses multi-stage builds for optimization:

1. **dev-deps** - Install all dependencies
2. **builder** - Generate Prisma Client and build application
3. **prod-deps** - Install only production dependencies
4. **release** - Final production image with minimal size

## 🙏 Acknowledgments

- [NestJS](https://nestjs.com/)
- [Prisma](https://www.prisma.io/)
- [Bun](https://bun.sh/)
- [PostgreSQL](https://www.postgresql.org/)
