package teste.web;

import org.apache.log4j.Logger;
import teste.servicos.login.ServiceLogin;
import teste.domain.UserSession;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends AbstractServlet
{
    private static final Logger logger = Logger.getLogger(LoginServlet.class);

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        logger.info("UM UTILIZADOR-----PEDE LOGIN COM O USERNAME:----" + user);
        logger.debug("UM UTILIZADOR------PEDE LOGIN COM A PASS------:" + pass);
        ServiceLogin servLogin = new ServiceLogin();
        if(servLogin.checkLogin(user, pass,null)){
            String roles = servLogin.returnRole();
            logger.info("UM UTILIZADOR-----PEDE LOGIN COM O USERNAME:----" + user);
            if(roles!=null){
                HttpSession session = req.getSession();
                session.setAttribute("username", user);
                session.setAttribute("roles", roles);
                Cookie userName = new Cookie("user", user);
                resp.addCookie(userName);
                String encodedURL = resp.encodeRedirectURL("home.do");
                resp.sendRedirect(encodedURL);
            }
            else{
                HttpSession session = req.getSession();
                session.setAttribute("username", user);
                session.setAttribute("roles", "normal");
                Cookie userName = new Cookie("username", user);
                resp.addCookie(userName);
                String encodedURL = resp.encodeRedirectURL("home.do");
                resp.sendRedirect(encodedURL);
            }
        }else{
            String encodedURL = resp.encodeRedirectURL("http://localhost:8080/projES/login.do?wrong_password");
            resp.sendRedirect(encodedURL);
        }

    }

    protected void doService(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}