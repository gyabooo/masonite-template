up:
	docker-compose up -d
build:
	docker-compose build --no-cache --force-rm
masonite-build:
	docker-compose -f docker-compose.masonite.yml build --no-cache --force-rm
masonite-install:
	mkdir -p ./backend/code
	docker-compose -f docker-compose.masonite.yml run --rm masonite craft new .
MASONITE_BUILD=true
create-project:
ifeq ($(MASONITE_BUILD),true)
	@make masonite-build
endif
	@make build
	@make masonite-install
	@make up
	rm -f ./backend/code/.env
	cp ./backend/masonite/.env ./backend/code/
	docker-compose exec app craft install
	docker-compose restart
	@make migrate
init:
	docker-compose up -d --build
	rm -f ./backend/code/.env
	cp ./backend/masonite/.env ./backend/code/
	docker-compose exec app craft install
	@make refresh
remake:
	@make destroy
	@make init
start:
	docker-compose start
stop:
	docker-compose stop
down:
	docker-compose down --remove-orphans
restart:
	@make down
	@make up
destroy:
	docker-compose down --rmi all --volumes --remove-orphans
destroy-volumes:
	docker-compose down --volumes --remove-orphans
destroy-masonite:
	docker-compose -f docker-compose.masonite.yml down --rmi all --volumes --remove-orphans
image-prune:
	docker image prune
builder-prune:
	docker builder prune
images-prune:
	@make image-prune
	@make builder-prune
ps:
	docker-compose ps
logs:
	docker-compose logs
logs-watch:
	docker-compose logs --follow
log-web:
	docker-compose logs web
log-web-watch:
	docker-compose logs --follow web
log-app:
	docker-compose logs app
log-app-watch:
	docker-compose logs --follow app
log-db:
	docker-compose logs db
log-db-watch:
	docker-compose logs --follow db
web:
	docker-compose exec web ash
app:
	docker-compose exec app bash
db:
	docker-compose exec db bash
migrate:
	docker-compose exec app craft migrate
refresh:
	docker-compose exec app craft migrate:refresh
sql:
	docker-compose exec db bash -c 'psql -U $$POSTGRES_USER $$POSTGRES_DB'
