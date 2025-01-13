# Template for create new project on Rails 8.0

- ruby 3.4.1
- postgres as database
- tailwind
- bun

```bash
rails new Rails-8.0-template -d postgresql --devcontainer -j bun -c tailwind
```

## Tests

- rspec
- cucumber

### Run self tests

```bash
script/run_before_push.sh
```

## Deploy

```bash
# Set variables when necessary, for example

export DATABASE_USER="postgres"
export DATABASE_PASSWORD="password"
export DATABASE_NAME="database"
export SECRET_KEY_BASE="1234567890"
export RAILS_ALLOWED_HOSTS="localhost 8.8.8.10"
export DATABASE_URL=postgres://${DATABASE_USER}:${DATABASE_PASSWORD}@db:5432
export APP_CONTAINER_PORT=3333
export RAILS_LOG_TO_STDOUT=true

docker compose -f compose.yml up -d --build

# Visit http://localhost:3333

```
