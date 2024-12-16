FROM node:16-alpine
WORKDIR /app
COPY server.js .
RUN npm install
CMD ["node", "server.js"]
EXPOSE 8080
