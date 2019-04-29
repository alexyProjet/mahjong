/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import fr.univubs.inf1603.mahjong.sapi.HumanInLobby;
import fr.univubs.inf1603.mahjong.sapi.SapiManager;
import fr.univubs.inf1603.mahjong.sapi.impl.SapiManagerImpl;
import java.io.IOException;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.GenericServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 *
 * @author aster
 */
public class SimpleInitServlet extends GenericServlet {

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext applicationServletContext = config.getServletContext();
        SapiManager sapiManager = new SapiManagerImpl();
        HashMap<UUID, HumanInLobby> ownerMap = new HashMap<>();
        HashMap<UUID, HumanInLobby> playerMap = new HashMap<>();
        applicationServletContext.setAttribute("SapiManager", sapiManager);
        applicationServletContext.setAttribute("ownerMap", ownerMap);
        applicationServletContext.setAttribute("playerMap", playerMap);
        System.out.println(sapiManager);
    }

    @Override
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
