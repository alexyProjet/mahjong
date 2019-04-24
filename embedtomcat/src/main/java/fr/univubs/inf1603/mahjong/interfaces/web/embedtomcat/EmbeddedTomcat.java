package fr.univubs.inf1603.mahjong.interfaces.web.embedtomcat;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.WebResourceRoot;
import org.apache.catalina.WebResourceSet;
import org.apache.catalina.core.StandardContext;
import org.apache.catalina.startup.Tomcat;
import org.apache.catalina.webresources.DirResourceSet;
import org.apache.catalina.webresources.EmptyResourceSet;
import org.apache.catalina.webresources.StandardRoot;
import org.apache.tomcat.util.scan.Constants;

import org.apache.tomcat.util.scan.StandardJarScanFilter;

/**
 * Cette classe permet d'écrire une application incluant Tomcat en son sein.
 * Cette classe est basé sur l'article : Create a Java Web Application Using
 * Embedded Tomcat
 *
 * @see
 * https://devcenter.heroku.com/articles/create-a-java-web-application-using-embedded-tomcat
 *
 * @author Erik MAZOYER
 * @author Heroku Dev Center
 */
public abstract class EmbeddedTomcat {

    /**
     * Logger
     */
    public static final Logger LOGGER = Logger.getLogger(EmbeddedTomcat.class.getName());

    /**
     * Serveur Tomcat
     */
    protected Tomcat tomcat;
    /**
     * Dossier racine de l'application web
     */
    protected File root;

    /**
     * Constructeur d'un serveur écoutant par défaut sur le port 8080. Si le
     * port est défini dans les variables d'environnement ce sera le port des
     * variables d'environnement qui sera utilisé.
     *
     * @throws IOException
     */
    public EmbeddedTomcat() throws IOException {
        this(8080);
    }

    /**
     * Constructeur d'un serveur écoutant par défaut sur le port indiqué. Si le
     * port est défini dans les variables d'environnement ce sera le port des
     * variables d'environnement qui sera utilisé.
     *
     * @param defaultPort Port utilisé par défaut.
     * @throws IOException
     */
    public EmbeddedTomcat(int defaultPort) throws IOException {
        tomcat = new Tomcat();

        // Le port peut être défini dans les variables d'environnement.
        // S'il est défini il est utilisé sinon c'est le port par défaut qui est utilisé.
        String webPort = System.getenv("PORT");

        int port;
        if (webPort == null || webPort.isEmpty()) {
            port = defaultPort;
        } else {
            port = Integer.valueOf(webPort);
        }
        tomcat.setPort(port);
        LOGGER.info("Tomcat port listening: " + port);
        // Détermination du dossier racine de l'application web
        root = getRootFolder();
        LOGGER.info("application resolved root folder: " + root.getAbsolutePath());
        System.setProperty("org.apache.catalina.startup.EXIT_ON_INIT_FAILURE", "true");
        Path tempPath = Files.createTempDirectory("tomcat-base-dir");
        tomcat.setBaseDir(tempPath.toString());
        LOGGER.info("tomcat-base-dir folder: " + tempPath.toString());

        tomcat.setSilent(false);
    }

    /**
     * Retourne le serveur Tomcat.
     *
     * @return Le serveur Tomcat.
     */
    public Tomcat getTomcat() {
        return tomcat;
    }

    /**
     * Retourne le dossier correspondant à la racine de l'application. Le
     * dossier racine est déterminé à partir du ProtectionDomain de la classe.
     * Fonctionne si cette classe est bien instanciée et utilisée dans le Main.
     *
     * @return Le dossier correspondant à la racine de l'application.
     */
    public static File getRootFolder() {
        try {
            File root;
            String runningJarPath = EmbeddedTomcat.class.getProtectionDomain().getCodeSource().getLocation().toURI().getPath().replaceAll("\\\\", "/");
            int lastIndexOf = runningJarPath.lastIndexOf("/target/");
            if (lastIndexOf < 0) {
                root = new File("");
            } else {
                root = new File(runningJarPath.substring(0, lastIndexOf));
            }
            return root;
        } catch (URISyntaxException ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * Permet d'initialiser le context de l'application
     *
     * @param servletContect Context de l'application.
     */
    protected abstract void initApplicationContext(ServletContext servletContext);

    /**
     * Initialisation
     *
     * @return Le context standard.
     * @throws IOException
     * @throws ServletException
     */
    protected StandardContext initApplication() throws IOException, ServletException {
        File webContentFolder = new File(root.getAbsolutePath(), "../servlets/src/main/webapp/");
        if (!webContentFolder.exists()) {
            webContentFolder = Files.createTempDirectory("default-doc-base").toFile();
        }
        // L'application est la seule et répond à la racine du serveur.
        // Le premier paramètre est donc la chaine vide.
        StandardContext ctx = (StandardContext) tomcat.addWebapp("",
                webContentFolder.getAbsolutePath());
        ServletContext servletContext = ctx.getServletContext();
        initApplicationContext(servletContext);
        //Set execution independent of current thread context classloader (compatibility withexec:java mojo)
        ctx.setParentClassLoader(EmbeddedTomcat.class.getClassLoader());
        LOGGER.info("configuring app with basedir: " + webContentFolder.getAbsolutePath());
        // Declare an alternative location for your "WEB-INF/classes" dir
        // Servlet 3.0 annotation will work
        File additionWebInfClassesFolder = new File(root.getAbsolutePath(), "target/classes");
        WebResourceRoot resources = new StandardRoot(ctx);
        WebResourceSet resourceSet;
        if (additionWebInfClassesFolder.exists()) {
            resourceSet = new DirResourceSet(resources, "/WEB-INF/classes",
                    additionWebInfClassesFolder.getAbsolutePath(), "/");
            LOGGER.config("loading WEB-INF resources from as '"
                    + additionWebInfClassesFolder.getAbsolutePath() + "'");
        } else {
            resourceSet = new EmptyResourceSet(resources);
        }
        resources.addPreResources(resourceSet);
        ctx.setResources(resources);
        return ctx;
    }

    /**
     * Démarre le serveur et le place en état d'écoute.
     *
     * @throws IOException
     * @throws ServletException
     * @throws LifecycleException
     */
    public void launch() throws IOException, ServletException, LifecycleException {
        StandardContext ctx = initApplication();
        String webxmlDirLocation = "../servlets/src/main/webapp/WEB-INF/web.xml";
        ctx.setDefaultWebXml(new File(root.getAbsolutePath(), webxmlDirLocation).getAbsolutePath());

        //Disable TLD scanning by default
        if (System.getProperty(Constants.SKIP_JARS_PROPERTY) == null
                && System.getProperty(Constants.SKIP_JARS_PROPERTY) == null) {
            LOGGER.info("disabling TLD scanning");
            StandardJarScanFilter jarScanFilter = (StandardJarScanFilter) ctx.getJarScanner().getJarScanFilter();
            jarScanFilter.setTldSkip("*");
        }
        tomcat.start();
        tomcat.getServer().await();
    }

    /**
     * Arrète le serveur
     *
     * @throws LifecycleException
     */
    public void stop() throws LifecycleException {
        tomcat.stop();
    }

}
