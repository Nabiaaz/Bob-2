FROM nginx:alpine

# Copie du fichier de configuration Nginx optimisé
COPY nginx.conf /etc/nginx/nginx.conf

# Exposition du port d'écoute principal pour Cloud Run / conteneur
EXPOSE 8080

# Lancement de Nginx au premier plan
CMD ["nginx", "-g", "daemon off;"]

