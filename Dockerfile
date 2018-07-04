FROM nginx:alpine
LABEL maintainer "Ed Marshall (ed@infinityworks.com)"
LABEL Description Nginx auth secured to expose static ressources
LABEL Vendor      Cabestan
LABEL Version     1.0
LABEL Maintainer  Raf <benmansour_rafik@yahoo.fr>

RUN apk update &&\
    apk add apache2-utils
COPY nginx.conf /etc/nginx/nginx.conf
COPY create_secret.sh .
COPY users_list.txt .
RUN chmod +x create_secret.sh
RUN ./create_secret.sh users_list.txt
