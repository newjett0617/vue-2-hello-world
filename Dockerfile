# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
