FROM justadudewhohacks/opencv-nodejs

# Workdir
RUN mkdir /app
WORKDIR /app

EXPOSE 8080

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install yarn

ENV NODE_ENV development

COPY package.json .
COPY yarn.lock .

RUN yarn install --production=true

CMD [ "echo", "456" ]
