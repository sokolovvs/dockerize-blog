start:
		docker-compose up --build --remove-orphans
start-daemon:
		docker-compose up --build --remove-orphans -d
stop-daemon:
		docker ps -aq --filter="name=dockerizeblog" | xargs -r docker stop