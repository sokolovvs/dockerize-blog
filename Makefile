start:
		docker-compose up -d --build --remove-orphans
stop:
		docker ps -aq --filter="name=dockerizeblog" | xargs -r docker stop