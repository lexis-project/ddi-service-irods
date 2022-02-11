# iRODS Docker images

## Available images

- *irods-server*: Standalone iRODS server with POSIX resource and builtin PostgreSQL server, can be set either as consumer or provider
- *irods-devel*: Image with development tools installed necessary for building iRODS plugins

### How to create images
```
cd irods-server
docker build -t irods-server .
```

## Start server
Server is setup (consumer and also provider) during the first start and it is 
automatically started. IRODS admin username/password is:
```
'rods'/'admin'
```

### Running provider
Start provider container with
```
./start_provider <host name>
```
Ctrl-C deattachs from console.

Connection to the provider is available through 
```
./login_provider
```
Stop and remove provider container with:
```
./stop_provider
```

Only stop provider container with:
```
docker stop irods-provider
```

### Running consumer
Start consumer container with
```
./start_consumer <host name> <host name of provider> [ip address of provider]
```
Ctrl-C deattachs from console.

IP address is provided in a case that host name of provider is not a DNS name. 
In a case that host name of consumer is not a DNS name you have to manually modify a file
/etc/hosts in a provider container before a start of the consumer container.

Connection to the consumer is available through 
```
./login_consumer
```
Stop and remove consumer container with:
```
./stop_consumer
```

Only stop provider container with:
```
docker stop irods-consumer
```

