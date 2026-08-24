FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Installation propre de Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Copie de votre configuration nginx.conf vers le dossier par défaut d'Ubuntu
COPY nginx.conf /etc/nginx/sites-available/default
RUN ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Adaptation automatique du port 80 vers le port 8080 pour Cloud Run
RUN sed -i 's/listen 80 default_server;/listen 8080 default_server;/g' /etc/nginx/sites-available/default

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
