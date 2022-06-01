FROM node:16-alpine as builder
USER node
#Create directory inside container
RUN mkdir -p /home/node/app
# Set the base directory
WORKDIR /home/node/app
# Copy package.json and give permisions to user
COPY --chown=node:node ./package.json ./
#Run npm install
RUN npm install
# Copy all directories and give permisions to user.
COPY --chown=node:node ./ ./
#run command npm run build
RUN npm run build
#Use docker image nginx
FROM nginx
# Assign ports. Only used for AWS. Does not work on the terminal
EXPOSE 80 
#Passes buid from builder image to nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html

