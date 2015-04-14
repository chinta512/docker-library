# Installation
```sh
# add mysql container
docker run --name mysql -e MYSQL_ROOT_PASSWORD=mysql -d mysql

# deploy jasperserver
docker run --link mysql:mysql --name jasperserver -p 8080:8080 derekha2010/jasperserver
```
Here you are: http://192.168.59.103:8080/jasperserver
