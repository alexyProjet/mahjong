package fr.univubs.inf1603.mahjong.interfaces.web.embedtomcat;

import java.io.File;
import javax.servlet.ServletContext;


/**
 * Classe de lancement de l'application embarquant un serveur Tomcat
 */
public class Main {

    /**
     * Lancement
     *
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        EmbeddedTomcat embeddedTomcat = new EmbeddedTomcat(8081) {
            @Override
            protected void initApplicationContext(ServletContext servletContext) {
                
            }
        };
        //Tomcat tomcat = embeddedTomcat.getTomcat();
        embeddedTomcat.launch();
    }
}
