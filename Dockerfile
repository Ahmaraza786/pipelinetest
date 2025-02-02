# Step 1: Use a specific version of Node.js (v18.20.5) as a base image
FROM node:18.20.5

# Step 2: Set the working directory in the container
WORKDIR /usr/src/app

# Step 3: Copy the package.json and package-lock.json files to install dependencies
COPY package*.json ./
# Clean the node_modules directory (in case of previous issues)
RUN rm -rf /usr/src/app/node_modules

# Install npm packages
RUN npm install --retry 5


# Step 5: Copy the rest of your application code into the container
COPY . .

# Step 6: Make the application available on port 8080
EXPOSE 8080

# Step 7: Define the command to run your app
CMD ["npm", "start"]
