<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    String customerName = (String) request.getAttribute("customerName");
    Double checkingBalance = (Double) request.getAttribute("checkingBalance");
    Double savingsBalance = (Double) request.getAttribute("savingsBalance");
    List<String> recentTransactions = (List<String>) request.getAttribute("recentTransactions");

    // If user hits index.jsp directly (not via servlet), redirect to /home
    if (customerName == null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyBank Online – Accounts Overview</title>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background: #f3f4f6;
            margin: 0;
        }
        a { text-decoration: none; }

        /* Top global header */
        .top-bar {
            background: #c41230; /* red-ish bar similar to a big bank */
            color: #fff;
            padding: 8px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13px;
        }
        .top-bar .left span {
            margin-right: 15px;
            opacity: 0.9;
        }
        .top-bar .right a {
            color: #fff;
            margin-left: 20px;
            font-weight: 500;
        }

        /* Main header with "logo" + user info */
        .main-header {
            background: #ffffff;
            border-bottom: 1px solid #dcdcdc;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo-area {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .logo-box {
            width: 34px;
            height: 34px;
            border-radius: 4px;
            background: linear-gradient(135deg, #c41230, #002f6c);
        }
        .logo-text {
            font-weight: 700;
            font-size: 20px;
            color: #002f6c;
        }
        .user-area {
            text-align: right;
            font-size: 13px;
            color: #333;
        }
        .user-area .name {
            font-weight: bold;
            font-size: 14px;
        }
        .user-area .last-login {
            color: #777;
            margin-top: 2px;
        }

        /* Tab navigation (Accounts / Bill Pay / Transfers etc.) */
        .tab-bar {
            background: #ffffff;
            border-bottom: 1px solid #dcdcdc;
            padding: 0 30px;
        }
        .tabs {
            display: flex;
            gap: 25px;
            font-size: 14px;
        }
        .tab {
            padding: 12px 0;
            cursor: pointer;
            color: #555;
            border-bottom: 3px solid transparent;
        }
        .tab.active {
            color: #c41230;
            font-weight: bold;
            border-bottom-color: #c41230;
        }

        /* Layout */
        .page {
            display: flex;
            padding: 20px 30px;
            gap: 20px;
        }

        /* Left menu */
        .left-menu {
            width: 210px;
        }
        .menu-card {
            background: #fff;
            border-radius: 6px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            padding: 10px 0;
        }
        .menu-title {
            padding: 10px 16px;
            font-size: 13px;
            font-weight: bold;
            color: #555;
            border-bottom: 1px solid #eee;
        }
        .menu-item {
            padding: 8px 16px;
            font-size: 13px;
            color: #444;
            cursor: pointer;
        }
        .menu-item:hover {
            background: #f6f7f9;
        }
        .menu-item.active {
            border-left: 3px solid #c41230;
            padding-left: 13px;
            background: #f9f1f3;
            font-weight: bold;
        }

        /* Center content */
        .center {
            flex: 1.6;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .card {
            background: #fff;
            border-radius: 6px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.08);
            padding: 16px 18px;
        }
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 12px;
        }
        .card-title {
            font-size: 15px;
            font-weight: bold;
            color: #333;
        }
        .card-subtitle {
            font-size: 12px;
            color: #777;
        }

        /* Accounts table */
        .accounts-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
            margin-top: 6px;
        }
        .accounts-table th,
        .accounts-table td {
            padding: 10px 6px;
            text-align: left;
        }
        .accounts-table thead th {
            border-bottom: 1px solid #e0e0e0;
            color: #777;
            font-weight: 600;
            font-size: 12px;
        }
        .accounts-table tbody tr:nth-child(even) {
            background: #fafafa;
        }
        .account-name {
            color: #0066c0;
            font-weight: 600;
        }
        .amount {
            text-align: right;
            font-weight: 600;
        }
        .positive {
            color: #006600;
        }
        .negative {
            color: #c41230;
        }

        /* Quick actions */
        .quick-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        .btn {
            display: inline-block;
            border-radius: 3px;
            padding: 8px 14px;
            font-size: 12px;
            border: 1px solid #c41230;
            color: #c41230;
            background: #fff;
            cursor: pointer;
        }
        .btn.primary {
            background: #c41230;
            color: #fff;
        }
        .btn.secondary {
            border-color: #ccc;
            color: #333;
        }

        /* Transactions list */
        .transactions-list {
            list-style: none;
            margin: 0;
            padding: 0;
        }
        .transactions-list li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            font-size: 13px;
            display: flex;
            justify-content: space-between;
        }
        .transactions-list li span {
            max-width: 70%;
        }

        /* Right side (alerts & promo) */
        .right {
            flex: 0.9;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .alert-item {
            font-size: 13px;
            margin: 8px 0;
        }
        .alert-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #c41230;
            display: inline-block;
            margin-right: 6px;
        }
        .promo {
            font-size: 13px;
            line-height: 1.5;
        }
        .promo strong {
            display: block;
            margin-bottom: 4px;
        }

        .footer {
            text-align: center;
            font-size: 11px;
            color: #999;
            padding: 20px 0;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .page {
                flex-direction: column;
            }
            .left-menu {
                width: 100%;
            }
            .center, .right {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- Top red bar -->
<div class="top-bar">
    <div class="left">
        <span>Personal</span>
        <span>Small Business</span>
        <span>Corporate</span>
    </div>
    <div class="right">
        <a href="#">Help &amp; Support</a>
        <a href="#">Profile &amp; Settings</a>
        <a href="<%= request.getContextPath() %>/logout">Sign Out</a>
    </div>
</div>

<!-- Main header -->
<div class="main-header">
    <div class="logo-area">
        <div class="logo-box"></div>
        <div class="logo-text">MyBank Online</div>
    </div>
    <div class="user-area">
        <div class="name"><%= customerName %></div>
        <div class="last-login">
            Last sign in:
            <%
                java.time.LocalDateTime lastLogin =
                        java.time.LocalDateTime.now().minusHours(3).withNano(0);
                out.print(lastLogin.toString().replace('T', ' '));
            %>
        </div>
    </div>
</div>

<!-- Tabs -->
<div class="tab-bar">
    <div class="tabs">
        <div class="tab active">Accounts</div>
        <div class="tab">Bill Pay</div>
        <div class="tab">Transfers</div>
        <div class="tab">Zelle® / Payments</div>
        <div class="tab">Rewards</div>
    </div>
</div>

<!-- Page body -->
<div class="page">
    <!-- Left Navigation -->
    <div class="left-menu">
        <div class="menu-card">
            <div class="menu-title">Navigation</div>
            <div class="menu-item active">Accounts Overview</div>
            <div class="menu-item">Activity &amp; Statements</div>
            <div class="menu-item">Bill Pay</div>
            <div class="menu-item">Transfer Money</div>
            <div class="menu-item">Alerts &amp; Notifications</div>
            <div class="menu-item">Profile &amp; Settings</div>
        </div>
    </div>

    <!-- Center content -->
    <div class="center">
        <!-- Accounts overview card -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">Accounts Overview</div>
                <div class="card-subtitle">View balances and recent activity</div>
            </div>

            <table class="accounts-table">
                <thead>
                <tr>
                    <th>Account</th>
                    <th>Account Number</th>
                    <th>Available Balance</th>
                    <th>Current Balance</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td class="account-name">MyBank Advantage Checking</td>
                    <td>•••• 1234</td>
                    <td class="amount positive">
                        $<%= String.format("%.2f", checkingBalance) %>
                    </td>
                    <td class="amount positive">
                        $<%= String.format("%.2f", checkingBalance + 50.00) %>
                    </td>
                </tr>
                <tr>
                    <td class="account-name">MyBank Rewards Savings</td>
                    <td>•••• 5678</td>
                    <td class="amount positive">
                        $<%= String.format("%.2f", savingsBalance) %>
                    </td>
                    <td class="amount positive">
                        $<%= String.format("%.2f", savingsBalance) %>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="quick-actions">
                <button class="btn primary">Make a Transfer</button>
                <button class="btn">Pay a Bill</button>
                <button class="btn secondary">View Statements</button>
            </div>
        </div>

        <!-- Recent transactions -->
        <div class="card">
            <div class="card-header">
                <div class="card-title">Recent Checking Activity</div>
                <div class="card-subtitle">Last 5 transactions</div>
            </div>
            <ul class="transactions-list">
                <%
                    if (recentTransactions != null) {
                        for (String tx : recentTransactions) {
                %>
                <li>
                    <span><%= tx %></span>
                    <span class="amount <%= tx.contains(\"-\") ? \"negative\" : \"positive\" %>">
                        <%
                            // Crude amount detection just for display:
                            String[] parts = tx.split("\\$");
                            if (parts.length > 1) {
                                out.print("$" + parts[1]);
                            }
                        %>
                    </span>
                </li>
                <%
                        }
                    }
                %>
            </ul>
        </div>
    </div>

    <!-- Right side: alerts + promo -->
    <div class="right">
        <div class="card">
            <div class="card-header">
                <div class="card-title">Alerts &amp; Messages</div>
            </div>
            <div class="alert-item">
                <span class="alert-dot"></span>
                Upcoming payment due in 3 days.
            </div>
            <div class="alert-item">
                <span class="alert-dot"></span>
                Low balance alert threshold set to $500.
            </div>
            <div class="alert-item">
                <span class="alert-dot"></span>
                New e-statement available for Checking.
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <div class="card-title">MyBank Insights</div>
            </div>
            <div class="promo">
                <strong>Track your spending by category</strong>
                See how much you spend on groceries, dining, and more with simple charts and insights.
            </div>
            <div class="promo" style="margin-top:10px;">
                <strong>Set savings goals</strong>
                Create automatic transfers from Checking to Savings to reach your goals faster.
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    &copy; <%= java.time.Year.now() %> MyBank Online. All rights reserved. |
    Privacy &amp; Security | Terms &amp; Conditions
</div>

</body>
</html>
