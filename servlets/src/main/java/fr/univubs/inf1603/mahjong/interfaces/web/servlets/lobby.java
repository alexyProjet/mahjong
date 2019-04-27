/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import fr.univubs.inf1603.mahjong.sapi.Lobby;
import fr.univubs.inf1603.mahjong.sapi.PlayerInLobby;
import fr.univubs.inf1603.mahjong.exceptions.DestroyedLobbyException;
import fr.univubs.inf1603.mahjong.sapi.Difficulty;
import fr.univubs.inf1603.mahjong.sapi.HumanInLobby;
import fr.univubs.inf1603.mahjong.sapi.SapiManager;
import fr.univubs.inf1603.mahjong.sapi.SimpleGame;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aster
 */
public class lobby extends MahjongServlet {

    SimpleGame game;
    Lobby lobby;
    List<Lobby> lobbies;
    HumanInLobby ownerLobby;
    int nbReadyPlayers;

    //sapiManager=(SapiManagerImpl) this.getServletContext().getAttribute("sapiManager");
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
    protected void doGet(HttpServletRequest request, final HttpServletResponse response)
            throws ServletException, IOException {

        SapiManager sapiManager = getSapiManager(request);
        String playerId = request.getParameter("playerId");
        String lobbyId = request.getParameter("lobbyId");
        List<PlayerInLobby> players;
        if (lobbyId != null) {
            if (sapiManager.getGame(UUID.fromString(lobbyId)) != null) {
                response.sendRedirect("/game?gameId=" + lobbyId + "&playerId=" + playerId);
            }
            lobby = sapiManager.getLobby(UUID.fromString(lobbyId));
            if (lobby != null) {
                try {
                    nbReadyPlayers = 0;
                    players = lobby.getPlayers();
                    for (int i = 0; i < lobby.getNumberOfPlayer(); i++) {
                        if (players.get(i) instanceof fr.univubs.inf1603.mahjong.sapi.impl.BotInLobbyImpl) {
                            nbReadyPlayers += 1;
                        } else if (getMyHuman(request, players.get(i).getUUID()).isReady() == true) {
                            nbReadyPlayers += 1;
                        } else {
                            System.out.println(i);
                        }
                    }
                    request.setAttribute("playerId", playerId);
                    request.setAttribute("lobby", lobby);
                    request.setAttribute("nbReadyPlayers", nbReadyPlayers);
                    this.getServletContext().getRequestDispatcher("/lobby.jsp").forward(request, response);
                } catch (DestroyedLobbyException ex) {
                    Logger.getLogger(lobby.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
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
        String lobbyId = request.getParameter(("lobbyId"));
        String playerId = request.getParameter("playerId");

        boolean isStart;
        isStart = false;
        PrintWriter writer = response.getWriter();
        SapiManager sapiManager = getSapiManager(request);

        lobby = sapiManager.getLobby(UUID.fromString(lobbyId));
        ownerLobby = getOwner(request, UUID.fromString(lobbyId));
        if (ownerLobby.getUUID().toString().equals(playerId)) {
            try {
                if ("addBot".equals(action)) {
                    lobby.addBot(Difficulty.SILLY, ownerLobby);
                    writer.print(lobby.getPlayers());
                } else if ("removePlayer".equals(action)) {
                    int idPlayer = Integer.parseInt(request.getParameter("idPlayer"));
                    lobby.removePlayer(lobby.getPlayers().get(idPlayer), ownerLobby);
                } else if ("launchGame".equals(action)) {
                    String id = lobby.getUUID().toString();
                    isStart = lobby.startGame(ownerLobby);
                    writer.append(id);
                } else if("changeVisibility".equals(action)){
                    lobby.setVisible(ownerLobby);
                }
            } catch (DestroyedLobbyException ex) {
                Logger.getLogger(lobby.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if ("setReady".equals(action) && playerId != null) {
            HumanInLobby humanInLobby = getMyHuman(request, UUID.fromString(playerId));
            if (humanInLobby.isReady()) {
                System.out.println("yes");
                humanInLobby.setReady(false);
            } else {
                humanInLobby.setReady(true);
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
