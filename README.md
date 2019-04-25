# mahjong

## Mise en place du projet sur NetBeans 8.2 :

### -télécharger le plugin Java EE Base (tools > plugin > Onglet Available plugins > chercher "Java EE")
### -ajout de Tomcat pour netbeans :
#####   -télécharger Tomcat 8.0.27 (https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.27/bin/)
    -Windows -> .exe
    -Linux -> .zip
      -Extraire à un endroit sur votre ordi
      -Donner les droits sur tous les fichiers (sudo chmod 754 *)
  
#####   -Dans Netbeans menu tools > servers > add servers > Apache Tomcat
    -Donner le chemin vers le Tomcat téléchargé précédement (ex : apache-tomcat-8.0.27)
    -Entrer un login et mdp pour un nouvel utilisateur (ex : tomcat tomcat)
    -close
    -Pour vérifier que le serveur Tomcat fonctionne, dans Netbeans en haut à gauche, dans l'onglet Services > Servers
      -Clic droit sur le Tomcat puis Start
      -Ouvrir un navigateur et accéder à localhost:8080
