FROM node:18-alpine

RUN apk add --no-cache tini vim
WORKDIR /usr/src/app

# Update
COPY src/package*.json /usr/src/app/.
RUN npm install
# RUN npm ci --only=production

ADD src /usr/src/app

EXPOSE 3000
ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "node", "./bin/www" ]
