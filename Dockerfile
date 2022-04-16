# 1st block --> build environment
# following commands is refer to builder phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2nd block --> server environment
# /app/build <-- all the stuff
# previous block all complete!
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/configfile.template

# copy from builder phase
COPY --from=builder /app/build /usr/share/nginx/html
# default will have start command automatically when container starts up

ENV PORT 8080
ENV HOST 0.0.0.0
EXPOSE 8080
CMD sh -c "envsubst '\$PORT' < /etc/nginx/conf.d/configfile.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"