build:
	sudo docker build -t aoki/api.glytoucan .

buildnc:
	sudo docker build --no-cache -t aoki/api.glytoucan .

run:
	sudo docker run -d --restart="always" -h local.api.glytoucan -p 881:8080 -v /opt/api.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/api.glytoucan:/workspace -w /workspace --name="api.glytoucan" -e "MAIL_ADDRESS_FROM=$(MAIL_ADDRESS_FROM)" -e "MAIL_ADDRESS_ADMIN=$(MAIL_ADDRESS_ADMIN)" -e "MAIL_BODY_NEWREGISTRATION=$(MAIL_BODY_NEWREGISTRATION)" -e "MAIL_BODY_NOTIFYREGISTRATION=$(MAIL_BODY_NOTIFYREGISTRATION)" -e "MAIL_SUBJECT_NEWREGISTRATION=$(MAIL_SUBJECT_NEWREGISTRATION)" -e "MAIL_SUBJECT_NOTIFYREGISTRATION=$(MAIL_SUBJECT_NOTIFYREGISTRATION)" -e "MSDB_RDF=$(MSDB_RDF)" -e "google.oauth2.clientId=$(GOOGLE_OAUTH2_CLIENTID)" -e "google.oauth2.clientSecret=$(GOOGLE_OAUTH2_CLIENTSECRET)" -e "SPRING_MAIL_USERNAME=$(SPRING_MAIL_USERNAME)" -e "SPRING_MAIL_PASSWORD=$(SPRING_MAIL_PASSWORD)" -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" maven:3.3.3-jdk-8 mvn -U spring-boot:run
	#sudo docker run -d --restart="always" -h local.api.glytoucan -p 881:80  -v /opt/api.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/api.glytoucan:/workspace -w /workspace --name="api.glytoucan" maven:3.3.3-jdk-8 mvn -U spring-boot:run

rundev:
	sudo docker run -d --restart="always" -h local.api.glytoucan -p 84:8080  -v /opt/test.api.glytoucan/maven:/root/.m2 -v ~/workspace/api.glytoucan:/workspace -w /workspace --name="api.glytoucan" -e "MAIL_ADDRESS_FROM=$(MAIL_ADDRESS_FROM)" -e "MAIL_ADDRESS_ADMIN=$(MAIL_ADDRESS_ADMIN)" -e "MAIL_BODY_NEWREGISTRATION=$(MAIL_BODY_NEWREGISTRATION)" -e "MAIL_BODY_NOTIFYREGISTRATION=$(MAIL_BODY_NOTIFYREGISTRATION)" -e "MAIL_SUBJECT_NEWREGISTRATION=$(MAIL_SUBJECT_NEWREGISTRATION)" -e "MAIL_SUBJECT_NOTIFYREGISTRATION=$(MAIL_SUBJECT_NOTIFYREGISTRATION)" -e "MSDB_RDF=$(MSDB_RDF)" -e "SPRING_MAIL_USERNAME=$(SPRING_MAIL_USERNAME)" -e "SPRING_MAIL_PASSWORD=$(SPRING_MAIL_PASSWORD)" -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" maven:3.3.3-jdk-8 mvn -U spring-boot:run

runtest:
	sudo docker run -d --restart="always" -h local.api.glytoucan -p 84:8080  -v /opt/test.api.glytoucan/maven:/root/.m2 -v /mnt/jenkins/workspace/test.api.glytoucan.org:/workspace -w /workspace --name="test.api.glytoucan" -e "MAIL_ADDRESS_FROM=$(MAIL_ADDRESS_FROM)" -e "MAIL_ADDRESS_ADMIN=$(MAIL_ADDRESS_ADMIN)" -e "MAIL_BODY_NEWREGISTRATION=$(MAIL_BODY_NEWREGISTRATION)" -e "MAIL_BODY_NOTIFYREGISTRATION=$(MAIL_BODY_NOTIFYREGISTRATION)" -e "MAIL_SUBJECT_NEWREGISTRATION=$(MAIL_SUBJECT_NEWREGISTRATION)" -e "MAIL_SUBJECT_NOTIFYREGISTRATION=$(MAIL_SUBJECT_NOTIFYREGISTRATION)" -e "MSDB_RDF=$(MSDB_RDF)" -e "google.oauth2.clientId=$(GOOGLE_OAUTH2_CLIENTID)" -e "google.oauth2.clientSecret=$(GOOGLE_OAUTH2_CLIENTSECRET)" -e "SPRING_MAIL_USERNAME=$(SPRING_MAIL_USERNAME)" -e "SPRING_MAIL_PASSWORD=$(SPRING_MAIL_PASSWORD)" -e "SPRING_TRIPLESTORE_PASSWORD=$(SPRING_TRIPLESTORE_PASSWORD)" -e "SPRING_TRIPLESTORE_URL=$(SPRING_TRIPLESTORE_URL)" maven:3.3.3-jdk-8 mvn -U spring-boot:run

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

testlogs:
	sudo docker logs --tail=100 -f test.api.glytoucan

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
