/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import fr.univubs.inf1603.mahjong.sapi.HumanInLobby;
import fr.univubs.inf1603.mahjong.sapi.Lobby;
import fr.univubs.inf1603.mahjong.sapi.SapiManager;
import java.io.IOException;
import java.io.Writer;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InvalidNameException;

/**
 *
 * @author aster
 */
public class joinLobby extends MahjongServlet {

    //SapiManagerImpl sapiManager = (SapiManagerImpl) this.getServletContext().getAttribute("sapiManager");
    List<Lobby> lobbies;
    boolean lobbyExists;
    Lobby lobby;
    HumanInLobby humanInLobby;

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
        HumanInLobbyImpl humanInLobby = new HumanInLobbyImpl("humainOwner");
        SimpleRuleImpl simpleRule = new SimpleRuleImpl("Maxime", "Traditionnal");
        Boolean visible = "Public".equals("Public");
        sapiManager.createLobby("Maxime", humanInLobby, simpleRule, visible,5,5);
         */
        SapiManager sapiManager = getSapiManager(request);

        List<Lobby> lobbyList = sapiManager.getVisibleLobbies();
        request.setAttribute("lobbyList", lobbyList);
        response.setIntHeader("Refresh", 5);
        this.getServletContext().getRequestDispatcher("/joinLobby.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SapiManager sapiManager = getSapiManager(request);
        Writer writer = response.getWriter();
        String lobbyId = request.getParameter("lobbyId");
        String playerName = request.getParameter("playerName");

        if (lobbyId != null & playerName != null) {
            try {
                humanInLobby = sapiManager.createHumanInLobby(playerName);
            } catch (InvalidNameException ex) {
                Logger.getLogger(joinLobby.class.getName()).log(Level.SEVERE, null, ex);
            }
            boolean isJoin = sapiManager.joinLobby(UUID.fromString(lobbyId), humanInLobby);
            if (isJoin) {
                setHumanInLobby(request, humanInLobby,humanInLobby.getUUID());
                writer.append(humanInLobby.getUUID().toString());
                response.setStatus(200);
            } else {
                response.setStatus(401);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
