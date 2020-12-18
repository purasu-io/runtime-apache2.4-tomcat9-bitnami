# Apache 2.4 + Tomcat 9 (Bitnami)

## Usage

Create local network if needed:
```bash
docker network create purasu-local
```

```bash
docker-compose up --build --force-recreate

# Apache web root
open http://localhost:8080

# Tomcat App Manager (via Apache)
# Dockerfile defaults:
#   TOMCAT_USERNAME = user
#   TOMCAT_USERNAME = password
open http://localhost:8080/manager/html
```

## Application

Static assets served by Apache:
* `/a/shared/public`

Application files served by Tomcat:
* `/app`

## Configuration

* [Bitnami instructions](https://github.com/bitnami/bitnami-docker-tomcat#configuration)
* If Tomcat web root is empty, example apps are copied from `/opt/bitnami/tomcat/webapps_default`
  * In the Purasu cluster, place the application files in `/app` which is a shared persistent volume.
  * (optional) To build a jar/war file into the image, place it in `/opt/bitnami/tomcat/webapps_default`.
