/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import fr.univubs.inf1603.mahjong.exceptions.DestroyedLobbyException;
import fr.univubs.inf1603.mahjong.exceptions.InvalidRuleException;
import fr.univubs.inf1603.mahjong.exceptions.UsedNameException;
import fr.univubs.inf1603.mahjong.sapi.Difficulty;
import fr.univubs.inf1603.mahjong.sapi.HumanInLobby;
import fr.univubs.inf1603.mahjong.sapi.Lobby;
import fr.univubs.inf1603.mahjong.sapi.SapiManager;
import fr.univubs.inf1603.mahjong.sapi.SimpleRule;
import java.io.IOException;
import java.io.Writer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InvalidNameException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author aster
 */
public class createLobby extends MahjongServlet {

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
        SapiManager sapiManager = getSapiManager(request);
        String name = request.getParameter("name");
        String visibility = request.getParameter("visibility");
        String rule = request.getParameter("rule");
        String playTime = request.getParameter("playTime");
        String stealTime = request.getParameter("stealTime");

        if (name != null) {
            request.setAttribute("name", name);
        }

        if (visibility != null & ("private".equals(visibility) | "public".equals(visibility))) {
            request.setAttribute("visibility", visibility);
        }

         if (sapiManager.getRules().contains(rule)) {
            request.setAttribute("selectedRule", rule);
        }

        if (playTime != null & stealTime != null) {
            request.setAttribute("time", stealTime);
            request.setAttribute("pickTime", stealTime);
        }
        
         request.setAttribute("rules",sapiManager.getRules());
        this.getServletContext().getRequestDispatcher("/createLobby.jsp").forward(request, response);
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

        String name = request.getParameter("name");
        String visibility = request.getParameter("visibility");
        String rule = request.getParameter("rule");
        String stringPlayTime = request.getParameter("playTime");
        String stringStealTime = request.getParameter("stealTime");
        String playerName = request.getParameter("playerName");
        Lobby lobby = null;
        HumanInLobby ownerLobby = null;
        Writer writer = response.getWriter();

        if (playerName != null & name != null & (visibility != null & ("Private".equals(visibility) | "Public".equals(visibility))) & (rule != null & ("Traditionnal".equals(rule))) & (stringPlayTime != null & stringStealTime != null)) {
            int stealTime = Integer.parseInt(stringStealTime);
            int playTime = Integer.parseInt(stringPlayTime);
            try {
                ownerLobby = sapiManager.createHumanInLobby(playerName);
                this.getServletContext().setAttribute("ownerLobby", ownerLobby);
                this.getServletContext().setAttribute("myPlayer", ownerLobby);
                SimpleRule simpleRule = sapiManager.getRules().get(0);
                Boolean visible = "Public".equals(visibility);
                lobby = sapiManager.createLobby(name, ownerLobby, simpleRule, visible, stealTime, playTime, Difficulty.SILLY);
                try {
                    setOwner(request,ownerLobby, lobby.getUUID());
                    setHuman(request,ownerLobby, ownerLobby.getUUID());
                } catch (DestroyedLobbyException ex) {
                    Logger.getLogger(createLobby.class.getName()).log(Level.SEVERE, null, ex);
                }
            } catch (InvalidNameException ex) {
                Logger.getLogger(lobby.class.getName()).log(Level.SEVERE, null, ex);
            } catch (UsedNameException | InvalidRuleException ex) {
                Logger.getLogger(createLobby.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                writer.append(lobby.getUUID().toString() + "\n");
                writer.append(ownerLobby.getUUID().toString());

            } catch (DestroyedLobbyException ex) {
                Logger.getLogger(createGame.class.getName()).log(Level.SEVERE, null, ex);
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
