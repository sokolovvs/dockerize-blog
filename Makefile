start:
		docker-compose up --build --remove-orphans -d #--scale queue-worker=2
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c "composer install --no-interaction --prefer-dist"
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan migrate --force --no-interaction -vvv'
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'npm run dev'
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan optimize'
stop:
		docker ps -aq --filter="name=dockerizeblog" | xargs -r docker stop
truncate-logs:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'truncate -s 0 storage/logs/laravel.log'
show-logs:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'watch -n 1 -c "tail -n 50 storage/logs/laravel.log | ccze -A"'
db-seed: #Run seeder in blog container
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'php artisan db:seed --force -vvv'
test:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'vendor/bin/phpunit --configuration phpunit.xml'