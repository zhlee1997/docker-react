
# following commands is refer to builder phase
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <-- all the stuff
# previous block all complete!
# 2nd block
FROM nginx
# copy from builder phase
COPY --from=builder /app/build /usr/share/nginx/html
# default will have start command automatically when container starts up