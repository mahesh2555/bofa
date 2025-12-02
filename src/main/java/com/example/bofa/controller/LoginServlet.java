package com.example.bofa.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LoginServlet - handles displaying the login page and processing login attempts.
 */
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 2L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        // If already logged in, go to /home
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userName") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Very simple validation – replace with real auth if needed
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Enter your Online ID and Passcode.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Successful "login" – create session
        HttpSession session = request.getSession(true);
        session.setAttribute("userName", username.trim());

        // Redirect to accounts dashboard
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
