/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import fr.univubs.inf1603.mahjong.engine.rule.Wind;
import fr.univubs.inf1603.mahjong.exceptions.DestroyedGameException;
import fr.univubs.inf1603.mahjong.exceptions.PlayerNotInGameException;
import fr.univubs.inf1603.mahjong.sapi.BoardView;
import fr.univubs.inf1603.mahjong.sapi.Player;
import fr.univubs.inf1603.mahjong.sapi.SapiManager;
import fr.univubs.inf1603.mahjong.sapi.SimpleGame;
import fr.univubs.inf1603.mahjong.tuto.TutoMahJong;
import fr.univubs.inf1603.mahjong.tuto.TutoTile;
import fr.univubs.inf1603.mahjong.tuto.TutoWind;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author leyyg
 */
public class game extends MahjongServlet {

    //SapiManagerImpl sapiManager = (SapiManagerImpl) this.getServletContext().getAttribute("sapiManager");
    TutoMahJong tutoMahjong;
    TutoWind windPlayer;
    TutoWind windBreach;
    int breachPosition;
    ArrayList<TutoTile> playerStartingHand;

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
        String isTuto = request.getParameter("tuto");

        if ("true".equals(isTuto)) {
            tutoMahjong = new TutoMahJong("fr");
            windPlayer = TutoWind.EST;
            windBreach = tutoMahjong.getBreachWind();
            breachPosition = tutoMahjong.getBreachPosition();
            playerStartingHand = tutoMahjong.getPlayerStartingHand();

            //Meld
            request.setAttribute("topMeld", "topMeld");
            request.setAttribute("rightMeld", "rightMeld");
            request.setAttribute("leftMeld", "leftMeld");
            request.setAttribute("bottomMeld", "bottomMeld");

            //BottomHand
            request.setAttribute("bottomHandTiles", playerStartingHand);
            //response.setIntHeader("Refresh", 2);

            //Wall
            request.setAttribute("topWall", "topWall");
            request.setAttribute("rightWall", "rightWall");
            request.setAttribute("leftWall", "leftWall");
            request.setAttribute("bottomWall", "bottomWall");

            //Discard
            request.setAttribute("topDiscard", "topDiscard");
            request.setAttribute("rightDiscard", "rightDisacrd");
            request.setAttribute("leftDiscard", "leftDiscard");
            request.setAttribute("bottomDiscard", "bottomDiscard");
        } else {
            String gameId = request.getParameter("gameId");
            SimpleGame game = sapiManager.getGame(UUID.fromString(gameId));
            String playerId = request.getParameter("playerId");
            try {
                Player player = game.getPlayerFromPlayerInLobby(getMyHuman(request, UUID.fromString(playerId)));
                game.launchGame();

                request.setAttribute("players", game.getPlayers());

                BoardView board = game.getBoard(player);

                request.setAttribute(gameId, board);

                //We define the common wall
                request.setAttribute("wall", board.getWall());

                //We define the attrributes of our player
                request.setAttribute("myPlayer", player);
                request.setAttribute("myHand", board.getHand(player.getWind()));
                request.setAttribute("myWind", player.getWind());
                request.setAttribute("myPoints", game.getPlayerPoints(player));
                request.setAttribute("myMeldZone0", board.getMeldZone0(player.getWind()));
                request.setAttribute("myMeldZone1", board.getMeldZone1(player.getWind()));
                request.setAttribute("myMeldZone2", board.getMeldZone2(player.getWind()));
                request.setAttribute("myMeldZone3", board.getMeldZone3(player.getWind()));
                request.setAttribute("myDiscardZone", board.getDiscardZone(player.getWind()));
                request.setAttribute("mySupremeZone", board.getSupremeZone(player.getWind()));
                request.setAttribute("myMoves", player.getMoves());

                //We define the attribute of east wind
                request.setAttribute("meldZoneEast0", board.getMeldZone0(Wind.EAST));
                request.setAttribute("meldZoneEast1", board.getMeldZone0(Wind.EAST));
                request.setAttribute("meldZoneEast2", board.getMeldZone2(Wind.EAST));
                request.setAttribute("meldZoneEast3", board.getMeldZone3(Wind.EAST));
                request.setAttribute("discardZoneEast", board.getDiscardZone(Wind.EAST));
                request.setAttribute("supremeZoneEast", board.getSupremeZone(Wind.EAST));

                //We define the attribute of west wind
                request.setAttribute("meldZoneWest0", board.getMeldZone0(Wind.WEST));
                request.setAttribute("meldZoneWest1", board.getMeldZone0(Wind.WEST));
                request.setAttribute("meldZoneWest2", board.getMeldZone2(Wind.WEST));
                request.setAttribute("meldZoneWest3", board.getMeldZone3(Wind.WEST));
                request.setAttribute("discardZoneWest", board.getDiscardZone(Wind.WEST));
                request.setAttribute("supremeZoneWest", board.getSupremeZone(Wind.WEST));

                //We define the attribute of south wind
                request.setAttribute("meldZoneSouth0", board.getMeldZone0(Wind.SOUTH));
                request.setAttribute("meldZoneSouth1", board.getMeldZone0(Wind.SOUTH));
                request.setAttribute("meldZoneSouth2", board.getMeldZone2(Wind.SOUTH));
                request.setAttribute("meldZoneSouth3", board.getMeldZone3(Wind.SOUTH));
                request.setAttribute("discardZoneSouth", board.getDiscardZone(Wind.SOUTH));
                request.setAttribute("supremeZoneSouth", board.getSupremeZone(Wind.SOUTH));

                //We define the attribute of north wind
                request.setAttribute("meldZoneNorth0", board.getMeldZone0(Wind.NORTH));
                request.setAttribute("meldZoneNorth1", board.getMeldZone0(Wind.NORTH));
                request.setAttribute("meldZoneNorth2", board.getMeldZone2(Wind.NORTH));
                request.setAttribute("meldZoneNorth3", board.getMeldZone3(Wind.NORTH));
                request.setAttribute("discardZoneNorth", board.getDiscardZone(Wind.NORTH));
                request.setAttribute("supremeZoneNorth", board.getSupremeZone(player.getWind()));

            } catch (DestroyedGameException | PlayerNotInGameException ex) {
                Logger.getLogger(game.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        this.getServletContext().getRequestDispatcher("/game.jsp").forward(request, response);
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
        this.getServletContext().getRequestDispatcher("/game.jsp").forward(request, response);
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
