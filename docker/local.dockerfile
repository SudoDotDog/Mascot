FROM sudoo/node:latest

# Workdir
RUN mkdir /app
WORKDIR /app

EXPOSE 8080

ENV NODE_ENV development

COPY package.json .
COPY yarn.lock .

RUN yarn install --production=true

CMD [ "echo", "456" ]
