# =========================================================
# Build Stage
# =========================================================
FROM node:16.15.0-alpine AS BUILD_IMAGE

# install packages and npm version 7
RUN apk update && \
    apk add curl && \
    curl -sf https://gobinaries.com/tj/node-prune | sh

# Create app directory
WORKDIR /app


# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm ci --silent

# Bundle app source
COPY . .


# run node prune
RUN node-prune


# =========================================================
# Runtime Stage
# =========================================================
FROM node:16.15.0-alpine

# Create app directory
WORKDIR /app

# copy from build image
COPY --from=BUILD_IMAGE /app .

EXPOSE 3000

CMD [ "npm", "run", "start" ]
