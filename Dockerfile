FROM node:10-slim

WORKDIR /usr/src/app

RUN npm install "@mapbox/whoots-js@3.1.0" && \
    sed -i "s/getURL(baseUrl, layer, x, y, z)/getURL(baseUrl, layer, x, y, z, {format: 'image\/jpeg', width: 512, height: 512})/g" node_modules/\@mapbox/whoots-js/server.js

EXPOSE 8080

CMD ["node", "node_modules/@mapbox/whoots-js/server.js"]
