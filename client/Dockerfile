FROM node:16-alpine as builder

# We are specifying that the USER which will execute RUN, CMD, or ENTRYPOINT
#  instructions will be the node user, as opposed to root (default).
USER node

# We are then creating a directory of /home/node/app prior to the WORKDIR instruction. 
# This will prevent a permissions issue since WORKDIR by default will create a
#  directory if it does not exist and set ownership to root.
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

# The inline chown commands will set ownership of the files you are copying from
#  your local environment to the node user in the container.
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./

RUN npm run build

# Fix for the permissions issue
# https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/11436998#questions/14297316

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /home/node/app/build /usr/share/nginx/html
