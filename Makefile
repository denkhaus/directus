include .env
export $(shell sed 's/=.*//' .env)


install:
	pnpm install

build: install
	pnpm build

initialize_database:
	pnpm --dir api cli bootstrap

dev_packages: build
	pnpm -r dev

dev_api:
	pnpm --filter api dev

dev_app:
	pnpm --filter app dev

docker_build:
	docker build -t $(DIRECTUS_IMAGE_NAME) .

docker_push: docker_build 
	docker push $(DIRECTUS_IMAGE_NAME)