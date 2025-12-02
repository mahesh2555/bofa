<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 'session' is an implicit JSP object – don't redeclare it
    if (session != null && session.getAttribute("userName") != null) {
        // Already logged in, go to home
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyBank Online – Sign In</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f4f6;
        }
        .top-bar {
            background: #c41230;
            color: #fff;
            padding: 8px 30px;
            display: flex;
            justify-content: space-between;
            font-size: 13px;
        }
        .top-bar .left span {
            margin-right: 15px;
            opacity: 0.9;
        }
        .top-bar .right a {
            color: #fff;
            margin-left: 20px;
            text-decoration: none;
            font-weight: 500;
        }

        .main {
            max-width: 900px;
            margin: 60px auto;
            display: flex;
            gap: 40px;
            padding: 0 20px;
        }
        .logo-area {
            margin-bottom: 20px;
        }
        .logo-box {
            width: 40px;
            height: 40px;
            border-radius: 4px;
            background: linear-gradient(135deg, #c41230, #002f6c);
            margin-bottom: 8px;
        }
        .logo-text {
            font-size: 22px;
            font-weight: 700;
            color: #002f6c;
        }

        .login-card {
            background: #fff;
            padding: 20px 24px;
            border-radius: 6px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.12);
            width: 360px;
        }
        .login-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 16px;
        }
        .field-label {
            font-size: 13px;
            margin-top: 10px;
            margin-bottom: 4px;
            color: #333;
        }
        .input {
            width: 100%;
            padding: 8px 10px;
            border-radius: 3px;
            border: 1px solid #b0b0b0;
            font-size: 13px;
        }
        .input:focus {
            outline: none;
            border-color: #c41230;
        }
        .error {
            margin-top: 10px;
            font-size: 12px;
            color: #c41230;
        }
        .remember-row {
            margin-top: 12px;
            font-size: 12px;
            display: flex;
            align-items: center;
            gap: 6px;
            color: #555;
        }
        .signin-btn {
            width: 100%;
            margin-top: 18px;
            padding: 9px 0;
            background: #c41230;
            color: #fff;
            border: none;
            border-radius: 3px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }
        .signin-btn:hover {
            background: #a00f28;
        }
        .links {
            margin-top: 14px;
            font-size: 12px;
        }
        .links a {
            color: #0066c0;
            text-decoration: none;
        }

        .right-info {
            flex: 1;
            font-size: 13px;
            color: #444;
        }
        .right-info h3 {
            margin-top: 0;
            margin-bottom: 8px;
        }
        .right-info ul {
            padding-left: 18px;
        }
        .right-info li {
            margin-bottom: 6px;
        }

        .footer {
            text-align: center;
            margin-top: 40px;
            font-size: 11px;
            color: #999;
        }
    </style>
</head>
<body>

<div class="top-bar">
    <div class="left">
        <span>Personal</span>
        <span>Small Business</span>
        <span>Corporate</span>
    </div>
    <div class="right">
        <a href="#">Help &amp; Support</a>
        <a href="#">Security Center</a>
    </div>
</div>

<div class="main">
    <div>
        <div class="logo-area">
            <div class="logo-box"></div>
            <div class="logo-text">MyBank Online</div>
        </div>

        <div class="login-card">
            <div class="login-title">Sign in to Online Banking</div>

            <form method="post" action="<%= request.getContextPath() %>/login">
                <div class="field-label">Online ID</div>
                <input type="text" name="username" class="input" autocomplete="username">

                <div class="field-label">Passcode</div>
                <input type="password" name="password" class="input" autocomplete="current-password">

                <div class="remember-row">
                    <input type="checkbox" id="remember" name="remember">
                    <label for="remember">Save Online ID on this device</label>
                </div>

                <% if (errorMessage != null) { %>
                    <div class="error"><%= errorMessage %></div>
                <% } %>

                <button type="submit" class="signin-btn">Sign In</button>

                <div class="links">
                    <div><a href="#">Forgot your Online ID?</a> | <a href="#">Forgot your Passcode?</a></div>
                    <div style="margin-top: 6px;">
                        Don’t have Online Banking? <a href="#">Enroll now</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="right-info">
        <h3>Secure, convenient banking</h3>
        <ul>
            <li>View balances and transactions for all your accounts in one place.</li>
            <li>Pay bills and transfer money between your accounts quickly.</li>
            <li>Set alerts to monitor balances, payments, and unusual activity.</li>
        </ul>

        <h3>Security tips</h3>
        <ul>
            <li>Always sign out and close your browser when finished.</li>
            <li>Never share your Online ID or Passcode with anyone.</li>
            <li>Verify the website address before entering your credentials.</li>
        </ul>
    </div>
</div>

<div class="footer">
    &copy; <%= java.time.Year.now() %> MyBank Online. All rights reserved. |
    Privacy &amp; Security | Terms &amp; Conditions
</div>

</body>
</html>
