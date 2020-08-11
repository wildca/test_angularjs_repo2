# docker-angularjs-container

This container contains enables to develop an AngularJS application.

## Bundled Software:
* [Node.js](https://nodejs.org/en/) a JavaScript runtime
* [Bower](http://bower.io/) a package manager
* [Less](http://lesscss.org/) a CSS pre-processor

## Build & Run the container
```
docker build https://github.com/iconicfuture/docker-angularjs-container.git -t docker-angularjs-container
docker run -n angularjs-01 -p 80:80 -v "/srv/[project path]:/srv/www" -d docker-angularjs-container
```
# test_angularjs_repo2
