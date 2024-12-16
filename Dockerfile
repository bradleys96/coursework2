FROM node:16-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json if available
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY server.js .

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["node", "server.js"]

