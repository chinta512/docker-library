# Installation
```sh
# add mysql container
docker run --name mysql -e MYSQL_ROOT_PASSWORD=mysql -d mysql

# get mysql container IP
MYSQL_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' mysql)

# init jasperserver db
docker run --link mysql:mysql -e "DB_TYPE=mysql" -e "DB_HOST=$MYSQL_IP" -e "DB_USER=root" -e "DB_PASSWORD=mysql" --rm -i derekha2010/jasperserver seed

# deploy jasperserver
docker run --link mysql:mysql -e "DB_TYPE=mysql" -e "DB_HOST=$MYSQL_IP" -e "DB_USER=root" -e "DB_PASSWORD=mysql" --name jasperserver -p 8080:8080 derekha2010/jasperserver
```
Here you are: http://192.168.59.103:8080/jasperserver
