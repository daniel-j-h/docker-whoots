# Docker images for whoots-js

Pre-built Docker images for [whoots-js](https://github.com/mapbox/whoots-js) and its Slippy Map Tiles -> WMS translation proxy.

Use Case
- you have an application working with [Slippy Map](https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames) tiles e.g. [robosat](https://github.com/mapbox/robosat)
- you have a raster tile WMS endpoint and want to translate Slippy Map tiles to WMS on the fly, e.g. [this WMS endpoint for aerial imagery](https://geoportal.bayern.de/geodatenonline/seiten/wms_dop80cm)

This Docker image provides a transparent translation proxy from Slippy Map to WMS on the fly.

For configuration check the [whoots-js](https://github.com/mapbox/whoots-js) documentation and server; and see our [Dockerfile](./Dockerfile) where we patch it on the fly for our use-cases.


# Usage

Run via

    docker run -p 5000:8080 danieljh/whoots

Now make Slippy Map requests against this proxy at `localhost:5000` and point it to the WMS endpoint

    http http://localhost:5000/tms/17/69500/44515/by_dop80c/https://geoservices.bayern.de/wms/v2/ogc_dop80_oa.cgi --follow --output tile.jpg

With robosat

    rs download --ext jpg --rate 10 'http://localhost:5000/tms/{z}/{x}/{y}/by_dop80c/https://geoservices.bayern.de/wms/v2/ogc_dop80_oa.cgi' bounds.tiles tiles

Note: if you run the downloader in a docker container, too, you have to pass `--network=host` for localhost to be accessible.


# Building

    docker build -r danieljh/whoots .
