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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InvalidNameException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aster
 */
public class createPlayer extends MahjongServlet {

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
        SapiManager sapiManager = getSapiManager(request);
        if (request.getParameter("playerName") != null) {
            try {
                humanInLobby = sapiManager.createHumanInLobby("joinPlayer");
            } catch (InvalidNameException ex) {
                Logger.getLogger(createPlayer.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("player", humanInLobby);
            this.getServletContext().getRequestDispatcher("/accueil.jsp").forward(request, response);
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
