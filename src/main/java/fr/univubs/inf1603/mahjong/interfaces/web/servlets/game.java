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
import fr.univubs.inf1603.mahjong.interfaces.controllertest.ControllerTest;
import fr.univubs.inf1603.mahjong.sapi.Lobby;
import fr.univubs.inf1603.mahjong.exceptions.DestroyedLobbyException;
import fr.univubs.inf1603.mahjong.tuto.TutoMahJong;
import fr.univubs.inf1603.mahjong.tuto.TutoTile;
import fr.univubs.inf1603.mahjong.tuto.TutoWind;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author leyyg
 */
public class game extends HttpServlet {

    ControllerTest controller = accueil.controllerTest;
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
            response.setIntHeader("Refresh", 2);

            

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
            String lobbyId = request.getParameter("lobbyId");
            Lobby lobby = controller.getLobby(lobbyId);

            try {
                lobby.startGame(lobby.getOwner());

            } catch (DestroyedLobbyException ex) {
                Logger.getLogger(game.class.getName()).log(Level.SEVERE, null, ex);
            }
            //Meld
            request.setAttribute("topMeld", "topMeld");
            request.setAttribute("rightMeld", "rightMeld");
            request.setAttribute("leftMeld", "leftMeld");
            request.setAttribute("bottomMeld", "bottomMeld");

            //BottomHand
            request.setAttribute("bottomHand", "bottomHand");

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
