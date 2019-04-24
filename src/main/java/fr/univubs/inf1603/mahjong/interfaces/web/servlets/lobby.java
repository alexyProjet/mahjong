/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import fr.univubs.inf1603.mahjong.ai.BotDifficulties;
import fr.univubs.inf1603.mahjong.ai.Difficulty;
import fr.univubs.inf1603.mahjong.interfaces.controllertest.ControllerTest;
import fr.univubs.inf1603.mahjong.sapi.impl.HumanInLobbyImpl;
import fr.univubs.inf1603.mahjong.sapi.impl.SimpleRuleImpl;
import fr.univubs.inf1603.mahjong.sapi.Lobby;
import fr.univubs.inf1603.mahjong.sapi.PlayerInLobby;
import fr.univubs.inf1603.mahjong.exceptions.DestroyedLobbyException;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aster
 */
public class lobby extends HttpServlet {

    ControllerTest controller = accueil.controllerTest;
    Lobby lobby;
    List<Lobby> lobbies;
    HumanInLobbyImpl humanInLobby;
    HumanInLobbyImpl ownerLobby;
    int nbReadyPlayers;

    boolean lobbyExists;

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
        String name = request.getParameter("name");
        String visibility = request.getParameter("visibility");
        String rule = request.getParameter("rule");
        String stringPlayTime = request.getParameter("playTime");
        String stringStealTime =request.getParameter("stealTime");
        String lobbyId = request.getParameter("lobbyId");
        String playerName = request.getParameter("playerName");
        List<PlayerInLobby> players;

        if (lobbyId != null) {
            lobby = controller.getLobby(lobbyId);
            if (lobby != null) {
                request.setAttribute("lobby", lobby);
                nbReadyPlayers = 0;
                try {
                    players = lobby.getPlayers();

                    for (int i = 0; i < lobby.getNumberOfPlayer(); i++) {
                        if (players.get(i).isReady()) {
                            nbReadyPlayers += 1;
                        }
                    }
                } catch (DestroyedLobbyException ex) {
                    Logger.getLogger(lobby.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("nbReadyPlayers", nbReadyPlayers);
                this.getServletContext().getRequestDispatcher("/lobby.jsp").forward(request, response);
            }
        } else if (playerName != null & name != null & (visibility != null & ("Private".equals(visibility) | "Public".equals(visibility))) & (rule != null & ("Traditionnal".equals(rule))) & (stringPlayTime != null & stringStealTime != null)) {
            //Ici on va créer un lobby grâce aux méthodes de SAPI
            
            int stealTime=Integer.parseInt(stringStealTime);
            int playTime=Integer.parseInt(stringPlayTime);
            lobbyExists = false;
            for (Lobby lobbyi : controller.getVisibleLobbies()) {
                try {
                    if (lobbyi.getName().equals(name)) {
                        lobbyExists = true;
                        lobby = lobbyi;
                        break;
                    }
                } catch (DestroyedLobbyException ex) {
                    Logger.getLogger(lobby.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                if (!lobbyExists) {
                    ownerLobby = controller.createHumanInLobby(playerName);
                    SimpleRuleImpl simpleRule = controller.createSimpleRule(name, rule);
                    Boolean visible = "Public".equals(visibility);

                    lobby = controller.createLobby(name, ownerLobby, simpleRule, visible, stealTime, playTime);

                    ownerLobby.setReady(true);
                }
                nbReadyPlayers = 0;

                players = lobby.getPlayers();
                for (int i = 0; i < lobby.getNumberOfPlayer(); i++) {
                    if (players.get(i).isReady()) {
                        nbReadyPlayers += 1;
                    }
                }
            } catch (DestroyedLobbyException ex) {
                Logger.getLogger(lobby.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("nbReadyPlayers", nbReadyPlayers);
            request.setAttribute("lobby", lobby);
            request.setAttribute("ownerUUID", ownerLobby.getUUID());
            this.getServletContext().getRequestDispatcher("/lobby.jsp").forward(request, response);
        } else {
            response.sendRedirect("/accueil");
        }
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

        String action = request.getParameter("action");
        if ("addBot".equals(action)) {
            try {
                lobby.addBot(BotDifficulties.Difficulty.SILLY, ownerLobby);
                PrintWriter writer = response.getWriter();
                writer.print(lobby.getPlayers());
            } catch (DestroyedLobbyException e) {
                System.out.println(e.getMessage());
            }
        } else if ("removePlayer".equals(action)) {
            int idPlayer = Integer.parseInt(request.getParameter("idPlayer"));
            try {
                lobby.removePlayer(lobby.getPlayers().get(idPlayer), ownerLobby);
            } catch (DestroyedLobbyException e) {
                System.out.println(e.getMessage());
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
