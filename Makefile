start:
		docker-compose up --build --remove-orphans -d #--scale queue-worker=2
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c "composer install --no-interaction --prefer-dist"
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan migrate --force --no-interaction -vvv'
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'npm run dev'
		make clear-cache
stop:
		docker ps -aq --filter="name=dockerizeblog" | xargs -r docker stop
db-seed: #Run seeder in blog container
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan db:seed --force -vvv'
test:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'vendor/bin/phpunit --configuration phpunit.xml'
clear-cache:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan optimize'
clear-es:
		curl -XDELETE localhost:19200/_all