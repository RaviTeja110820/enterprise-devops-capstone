# Use lightweight Node.js 20 image as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json first
# This helps Docker cache dependency installation
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the remaining application source code
COPY . .

# Expose the application port
EXPOSE 3000

# Start the Node.js application
CMD ["npm", "start"]
