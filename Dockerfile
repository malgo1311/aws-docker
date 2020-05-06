FROM node:alpine as builder

WORKDIR /app

COPY ./package.json ./
RUN npm install

COPY ./ ./

RUN npm run build

# The builder block cpopies all the files
# to the /app folder inside the container
# We need only the build folder to run in 
# out nginx server. So we copy this folder 
# to the nginx default directory
# -----------------------------------------

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

