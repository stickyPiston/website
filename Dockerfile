FROM node:lts-alpine

# Setup environment
WORKDIR /usr/src/app
EXPOSE 3001

# Copy sources
COPY . .

# Run npm commands and start server
RUN npm install
RUN npm run compile
CMD ["node", "/usr/src/app/dist/server.js"]
