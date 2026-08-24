FROM ubuntu:24.04

# Éviter les invites interactives pendant l'installation
ENV DEBIAN_FRONTEND=noninteractive

# Installer Nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Supprimer la configuration par défaut de Nginx
rm -f /etc/nginx/sites-enabled/default

# Copier votre fichier de configuration Nginx dans le conteneur
COPY default /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Google Cloud Run exige que le service écoute sur le port 8080 (ou $PORT)
# On modifie le port d'écoute HTTP dans le fichier pour correspondre à Cloud Run si besoin, 
# ou on s'assure que Nginx écoute sur 8080.
RUN sed -i 's/listen 80 default_server;/listen 8080 default_server;/g' /etc/nginx/sites-available/default

# Exposer le port pour Cloud Run
EXPOSE 8080

# Lancer Nginx au premier plan
CMD ["nginx", "-g", "daemon off;"]
