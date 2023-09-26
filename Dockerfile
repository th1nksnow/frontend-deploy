FROM node:alpine as build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# prod
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=build /app/.nginx/ /etc/nginx/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
