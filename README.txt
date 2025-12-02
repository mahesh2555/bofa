# BOFA-Style Online Banking Demo (Java + Maven + JSP + Servlets)

This is a simple demo web application that mimics a BOFA-style login and
accounts dashboard using Java Servlets, JSP, and Maven.

## How to run

1. Import this project into IntelliJ / Eclipse / VS Code as a Maven project  
   **OR** run from command line:

   mvn clean package

2. Deploy the generated WAR file:

   target/bofa-style-webapp.war

   to an Apache Tomcat server (Tomcat 9+ recommended).

3. Start Tomcat and open:

   http://localhost:8080/bofa-style-webapp/

   You should see the login page.

4. Use any Online ID and Passcode (non-empty), for example:

   Online ID: mahesh  
   Passcode: test123

   After signing in, you will be redirected to the BOFA-style accounts
   overview dashboard.

5. Click "Sign Out" in the top-right corner to end your session.
