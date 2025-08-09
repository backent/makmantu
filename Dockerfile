FROM node:jod-alpine3.21 AS buildstage
RUN npm install -g npm@10.8.2
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build

FROM nginx:stable-alpine AS productionstage
RUN mkdir /app
COPY --from=buildstage /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf
