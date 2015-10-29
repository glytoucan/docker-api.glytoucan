build:
	sudo docker build -t aoki/api.glytoucan .

buildnc:
	sudo docker build --no-cache -t aoki/api.glytoucan .

run:
	sudo docker run -d --restart="always" -h local.api.glytoucan -p 881:80  -v /opt/api.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/api.glytoucan:/workspace -w /workspace --name="api.glytoucan" maven:3.3.3-jdk-8 mvn -U spring-boot:run

rundev:
	sudo docker run -d --restart="always" -h local.api.glytoucan -p 81:8080  -v /opt/api.glytoucan/maven:/root/.m2 -v ~/workspace/api.glytoucan:/workspace -w /workspace --name="api.glytoucan"  maven:3.3.3-jdk-8 mvn -U --debug spring-boot:run

runtest:
	sudo docker run -d --restart="always" -h local.api.glytoucan -p 84:8080  -v /opt/test.api.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/test.api.glytoucan:/workspace -w /workspace --name="test.api.glytoucan"  maven:3.3.3-jdk-8 mvn -U spring-boot:run

bash:
	sudo docker exec -it api.glytoucan /bin/bash

ps:
	sudo docker ps

stop:
	sudo docker stop api.glytoucan

rm:
	sudo docker rm api.glytoucan

logs:
	sudo docker logs --tail=100 -f api.glytoucan

ip:
	sudo docker inspect -f "{{ .NetworkSettings.IPAddress }}" api.glytoucan

restart:
	sudo docker restart api.glytoucan

inspect:
	sudo docker inspect aoki/api.glytoucan

cleantest:
	sudo docker stop test.api.glytoucan
	sudo docker rm test.api.glytoucan

rerun: stop rm rund

cleandev: build stop rm rundev

clean: build stop rm rund

# not tested
dump:
	sudo docker export api.glytoucan > api.glytoucan.glycoinfo.tar

# not tested
load:
	cat api.glytoucan.glycoinfo.tar | docker import - aoki/docker-api.glytoucan:api.glytoucan
	
.PHONY: build run test clean
