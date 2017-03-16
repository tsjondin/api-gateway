# Proxy/Gateway Interface API manager

## Background

Why?

## Walkthrough

### Apache

I started with finding an apache container image, and located one that is
distributed by CentOS, i.e. it was the one provided on their github account.
This apache server rolls on a CentOS 7 and uses their run script in order to
start the apache server without using systemctl.

This apache cotainer works fine exposed on port 8080 of the host machine,
and I added a COPY statement in order to get some apache config into the
container for activating mod_proxy which was to be used for the endpoint
containers.

```
<IfModule !proxy_module>
  LoadModule proxy_module modules/mod_proxy.so
</IfModule>

ProxyRequests on
```

The directory structure now looks like:

* pgi
  * pgi
    * conf.d
      * api.conf
    * cccp.yml
    * Dockerfile
    * LICENSE
    * README.md
    * run-httpd.sh

### Node endpoint

I then created a node container running FROM the official node image and adding
a simple express catch-all app that binds to port 10000. I now needed to proxy
requests to the apache server on location /api/node.

So I added an apache config file to the endpoint's directory structure that
specifies how to proxy requests from the apache container to the node
container.

The node endpoints httpd conf
```
<Location /api/node>
        ProxyPass http://172.17.0.1:10000
        ProxyPassReverse http://172.17.0.1:10000
</Location>
```

But in order to get it into apache I decided that I would make the
folder containing all endpoints (repos) a shared volume for the apache
container.

Addition to the apache httpd conf
```
IncludeOptional /srv/repos/*/httpd/*.conf
```

With this configuration made I could now start the apache container and the
node container, send requests to the apache container on port 8080 and path
/api/node and it would proxy them to the node containers server process and
respond.

The directory structure now looks like:

* pgi
  * pgi
    * conf.d
      * api.conf
    * cccp.yml
    * Dockerfile
    * LICENSE
    * README.md
    * run-httpd.sh
  * repos
    * node
      * httpd
	* node.conf
    * Dockerfile
    * package.json
    * server.js


