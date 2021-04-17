FROM node as build
# Nos posicionamos en app
WORKDIR /usr/src/app
# Actualizamos npm
RUN npm install -g npm@latest
COPY ./app/package.json ./package.json
# Instalamos Angular en la máquina virtual
RUN npm install -g @angular/cli
# Movemos el App
COPY ./app/ /usr/src/app
# Instalamos las dependencias
RUN npm install
# Instalamos el servidor
RUN ng build

FROM nginx
#COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/app /usr/share/nginx/html
