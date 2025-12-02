package com.example.bofa.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * HomeServlet - shows the BOFA-style accounts dashboard after login.
 */
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        // Require login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userName") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userName = (String) session.getAttribute("userName");

        // Fake data similar to a banking dashboard
        String customerName = userName; // you can hardcode a full name if you want
        double checkingBalance = 2450.75;
        double savingsBalance = 10250.00;

        List<String> recentTransactions = Arrays.asList(
                "POS Purchase - Grocery Store - $45.60",
                "ATM Withdrawal - $100.00",
                "Online Transfer to Savings - $250.00",
                "Salary Credit - $3,000.00"
        );

        request.setAttribute("customerName", customerName);
        request.setAttribute("checkingBalance", checkingBalance);
        request.setAttribute("savingsBalance", savingsBalance);
        request.setAttribute("recentTransactions", recentTransactions);

        // Forward to BOFA-style JSP dashboard
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
