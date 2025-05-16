# Simulador do Caos
ira testar a conexão - Quebrar a aplicação - Encerrar aplicação - Consumo de CPU

### Variáveis de Ambiente

**SIGTERM_SECONDS**

Segundos para encerrar a aplicação

# imagem

kubedevio
fabricioveronez/simulador-do-caos:v1
raco21/simulador-do-caos:v1

# comandos

Estudo Docker

*Primeiro, baixe a imagem do Nginx do Docker Hub.
docker pull nginx

*Executar o Contêiner:
docker run --name meu-nginx -d -p 8080:80 nginx

*Passos para Alterar o Conteúdo do Nginx no Docker
Acessar o Contêiner via Shell:
docker exec -it meu-nginx /bin/bash

*Navegar até a Pasta Servida pelo Nginx:
No shell do contêiner, navegue até a pasta onde o Nginx serve seus arquivos. O caminho padrão é:
cd /usr/share/nginx/html

*Modificar o Conteúdo:
nano index.html

*Parar e Remover o Contêiner Existente:
docker stop meu-nginx
docker rm meu-nginx


*Acesso Via IP Externo:
curl ifconfig.me

*Confirmar o Status do Contêiner:
docker ps
docker start meu-nginx

ver volume
*Executar o Contêiner com um Volume:
docker run --name meu-nginx -d -p 8080:80 -v /caminho/para/sua/pasta:/usr/share/nginx/html nginx

*Docker file e criar imagem - executar dentro do diretorio scr
docker build -t raco21/kube-news:v2 .
docker images
docker tag raco21/kube-news:v2 raco21/kube-news:latest
docker push raco21/kube-news:v2

*comando para excluir uma imagem
docker rmi -f IMAGE ID
docker rmi $(docker images -q)

*comando para excluir os cantainers todos de uma vez
docker stop $(docker ps -aq)
docker containers rm -f $(Docker container ls -aq)

Docker_clean

*exemplo com volume - criar um arquivo no vscode index.html <h1>teste de texto</h1>
comando para criar o container ngnix e mapear o volume
Docker container run -d -p 8080:80 -v "$(pwd)/index.html:/usr/share/nginx/index.html" nginx

*Docker composse serve para criar mais de um container utilizando o mesmo arquivo yaml
crie um arquivo no vscode chamado dockercompose.yaml
e execute ele no Docker através do comando 
Docker compose -f compose.yaml up -d

*comando para matar o compose
Docker compose down

catalogo de composse do Fabricio no git
fabricioveronez/catalogo-docker-composse

*comando vai mostrar o catalogo da instalação antes de criar
Docker composse config



git clone https://github.com/fabricioveronez/catalogo-docker-composse

entrar no diretório onde baixou e executar - exemplo
cd WordPress/
Docker composse up -d
Docker composse down 

*ao criar uma instancia ec2 com o ubuntu e instalar o Docker com o nginx
sair e depois executar um terraform outpu para obter o endereço e acessar a aplicação nginx

*criação com o Docker commit - tem que instalar tudo na imagem antes de criar exemplo node.js
Docker commit conversão-temperatura
Docker run -it -p 8080:8080 conversão-temperatura /bin/bash
Docker commit -it -p 8080:8080 conversão-temperatura /app node server.js

*Docker image history
ver o histórico da criação da imagem

*Docker image inspect conversap-temperatura
traz informação em json

Docker image inspect conversap-temperatura > inspct.json
salva o arquivo em json para um melhor analise

*Docker image save conversao-temperatura > imagem.tar
converte a imagem em um arquivo

*Comando com volumes
cria o volume no diretório bind
docker container run -it --mount type=bind,source="$(pwd)/repo",target=/app ubuntu /bin/bash

cria o arquivo html no diretório e usa ele usando o volume
docker container run -d -p 8080:80 -v "$(pwd)/html:/usr/share/nginx/html" nginx

*comando para ver o volume
Docker volume create novo_volume
Docker volume ls -a
Docker volume inspect id-volume

*comando backup volume
https://docs.docker.com/storage/volumes/#back-up-restore-or-migrate-data-volumes

*comandos Docker para saber informações gerais Troubleshooting
Docker info

*mostrar eventos
Docker events

mostra evnos duas horas antes
docker events --since 2h

mostra eventos até 30m atras
docker events --until 30m

mostra eventos especificos
docker events --filter event=create

mostra os log online
docker container logs --follow id-container 

docker container logs --since 1m id-container

docker container logs --until 1m id-container

docker container logs --since '2025-05-01T08:11:00Z' id-container

docker container logs --tail 3 id-container

docker inspect id-container ou imagem

mostra os processos
Docker top id-container

mostra recursos operacionais
docker stats

mostra info 
docker stats --no-stream 

mostra info e vai atualizando
docker stats --no-trunc

docker exec -it id-container /bin/bash

*comando para restartar o container
docker container run -d -p 8080:3000 --restart=on-failure kubedevio/simulador-do-caos:v1
docker container run -d -p 8080:3000 --restart=on-failure:3 kubedevio/simulador-do-caos:v1
docker container run -d -p 8080:3000 --restart=unless-stopped kubedevio/simulador-do-caos:v1
docker container run -d -p 8080:3000 --restart=always kubedevio/simulador-do-caos:v1

watch 'docker container ls -a'

*restart no composse
declarar restart: Always em casa serviço

*Healthcheck
docker container run -d -p 8080:3000 --health-cmd "curl -f http://localhost:3000/health" --health-timeout 5s --health-retries 3 --health-interval 10s --health-start-period 30s kubedevio/simulador-do-caos:v1

no Docker composse basta apenas declarar que ele vai completar automaticamente

healthcheck: 

*verificação de cpu
htop

Docker stats

docker container run -d -p 8080:3000 --cpu-period=100000 --cpu-quota=50000 fabricioveronez/simulador-do-caos:v1

define qual cpu vai utilizar o processo - neste exemplo a 0
docker container run -d -p 8080:3000 --cpu-period=100000 --cpu-quota=50000 --cpuset-cpus=0 fabricioveronez/simulador-do-caos:v1

define a quantidade de cpu que vai utilizar
docker container run -d -p 8080:3000 --cpus=1.5  --cpuset-cpus=0-1 fabricioveronez/simulador-do-caos:v1

*gerenciamento de memoria
docker container run -d -p 8080:3000 --memory=50M --memory-swap=100M fabricioveronez/simulador-do-caos:v1

*como usar no Docker composse
