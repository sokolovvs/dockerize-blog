start:
		docker-compose up --build --remove-orphans
start-daemon:
		docker-compose up --build --remove-orphans -d
stop-daemon:
		docker ps -aq --filter="name=dockerizeblog" | xargs -r docker stop
truncate-logs:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'truncate -s 0 storage/logs/laravel.log'
show-logs:
		docker ps -aq --filter="name=dockerizeblog_blog" | xargs -I'{}' docker exec -t '{}' bash -c 'watch -n 1 -c "tail -n 50 storage/logs/laravel.log | ccze -A"'