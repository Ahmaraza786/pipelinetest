# Step 1: Use a specific version of Node.js (v18.20.5) as a base image
FROM node:18.20.5

# Step 2: Set the working directory in the container
WORKDIR /usr/src/app

# Step 3: Copy the package.json and package-lock.json files to install dependencies
COPY package*.json ./

# Clean the node_modules directory (in case of previous issues)
RUN rm -rf /usr/src/app/node_modules

# Step 4: Set npm registry to avoid network issues (optional)
RUN npm config set registry https://registry.npmjs.org/

# Step 5: Install npm packages with retries
RUN npm install --retry 5

# Step 6: Copy the rest of your application code into the container
COPY . .

# Step 7: Make the application available on port 8080
EXPOSE 8080

# Step 8: Define the command to run your app
CMD ["npm", "start"]
