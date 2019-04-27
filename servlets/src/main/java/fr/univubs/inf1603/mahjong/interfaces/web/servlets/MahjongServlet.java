/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import fr.univubs.inf1603.mahjong.sapi.HumanInLobby;
import fr.univubs.inf1603.mahjong.sapi.SapiManager;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author aster
 */
public class MahjongServlet extends HttpServlet {
    /**
     * This method return the sapiManager
     *
     * @param request
     * @return
     */
    protected SapiManager getSapiManager(HttpServletRequest request) {
        return (SapiManager) request.getServletContext().getAttribute("SapiManager");
    }

    /**
     * This method return the owner of the lobby
     *
     * @param request
     * @param lobbyId The olobby's id.
     * @return the PlayerInLobby who is the owner
     */
    protected HumanInLobby getOwner(HttpServletRequest request, UUID lobbyId) {
        HashMap<UUID, HumanInLobby> map = (HashMap<UUID, HumanInLobby>) request.getServletContext().getAttribute("ownerMap");
        return map.get(lobbyId);
    }

    /**
     * This method set a owner with his lobby
     *
     * @param request
     * @param humanInLobby
     * @param lobbyId
     */
    protected void setOwner(HttpServletRequest request, HumanInLobby humanInLobby, UUID lobbyId) {
        HashMap<UUID, HumanInLobby> map = (HashMap<UUID, HumanInLobby>) request.getServletContext().getAttribute("ownerMap");
        map.put(lobbyId, humanInLobby);
        request.getServletContext().setAttribute("ownerMap", map);
    }

    /**
     * This method return the player we want
     *
     * @param request
     * @param playerId the player's id
     * @return The player we want
     */
    protected HumanInLobby getMyHuman(HttpServletRequest request, UUID playerId) {
        HashMap<UUID, HumanInLobby> map = (HashMap<UUID, HumanInLobby>) request.getServletContext().getAttribute("playerMap");
        return map.get(playerId);
    }

    /**
     * This method set the player with his lobbyId
     *
     * @param request
     * @param player
     * @param lobbyId
     */
    protected void setHuman(HttpServletRequest request, HumanInLobby human, UUID humanInLobbyId) {
        HashMap<UUID, HumanInLobby> map = (HashMap<UUID, HumanInLobby>) request.getServletContext().getAttribute("playerMap");
        map.put(humanInLobbyId, human);
        request.getServletContext().setAttribute("playerMap", map);
    }

}
