start:
		bash ./installation.sh
		docker-compose up --build --remove-orphans -d #--scale queue-worker=2
		make composer-i
		make db-migrate
		make npm-i
		make clear-cache
stop:
		docker ps -aq --filter="name=dockerize-blog-dev" | xargs -r docker stop
db-seed: #Run seeder in blog container
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan db:seed --force -vvv'
db-migrate:
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan migrate --force --no-interaction -vvv'
npm-i:
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'npm run dev'
composer-i:
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c "composer install --no-interaction --prefer-dist"
test:
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'vendor/bin/phpunit --configuration phpunit.xml'
clear-cache:
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan optimize'
app-key-gen:
		docker ps -aq --filter="name=dockerize-blog-dev_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan key:generate'
clear-es:
		curl -XDELETE localhost:19200/_all