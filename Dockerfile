ARG NODE_IMAGE=node:16.13.1-alpine

FROM $NODE_IMAGE AS base
RUN apk --no-cache add dumb-init
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY . .
RUN mkdir tmp

FROM base AS production
RUN npm install 
RUN chown node:node ./package.json ./
RUN npm run build
RUN chown node:node /home/node/app/build .
CMD [ "dumb-init", "node", "server.js" ]