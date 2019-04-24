/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package fr.univubs.inf1603.mahjong.interfaces.web.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aster
 */
public class createGame extends HttpServlet {

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
        String name=request.getParameter("name");
        String visibility=request.getParameter("visibility");
        String rule=request.getParameter("rule");
        String playTime=request.getParameter("playTime");
        String stealTime=request.getParameter("stealTime");
        
        if(name!=null){
            request.setAttribute("name",name );
        }
        
        if (visibility!=null & ("private".equals(visibility) | "public".equals(visibility))){
            request.setAttribute("visibility", visibility);
        }
        
        if(rule!=null & ("traditionnal".equals(rule))){
            request.setAttribute("rule", rule);
        }
        
        if(playTime!=null & stealTime!=null){
            request.setAttribute("time", stealTime);
            request.setAttribute("pickTime", stealTime);
        } 
        this.getServletContext().getRequestDispatcher("/createGame.jsp").forward(request, response);
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
