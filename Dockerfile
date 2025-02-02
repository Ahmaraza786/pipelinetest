FROM node:18.20.5

WORKDIR /usr/src/app

COPY package*.json ./

# Clear npm cache and remove existing node_modules
RUN rm -rf /usr/src/app/node_modules && \
    npm cache clean --force

# Install dependencies with reduced memory usage
RUN npm install --production --no-optional --max-old-space-size=512

COPY . .

EXPOSE 3000

CMD ["npm", "start"]