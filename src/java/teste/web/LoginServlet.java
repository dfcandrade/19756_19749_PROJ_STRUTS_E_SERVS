package teste.web;

import org.apache.log4j.Logger;
import teste.domain.User;
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
        ServiceLogin servLogin = new ServiceLogin();
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        logger.info("UM UTILIZADOR-----PEDE LOGIN COM O USERNAME:----" + user);
        logger.debug("UM UTILIZADOR------PEDE LOGIN COM A PASS------:" + pass);
        User u = servLogin.checkLogin(user, pass,null);
        if(u != null){
            String roles = servLogin.returnRole();
            logger.info("UM UTILIZADOR-----PEDE LOGIN COM O USERNAME:----" + user);
            if(roles!=null){
                HttpSession session = req.getSession();
                req.setAttribute("userLoggedIn",u);
                session.setAttribute("username", user);
                session.setAttribute("roles", roles);
                String encodedURL = resp.encodeRedirectURL("home.do");
                resp.sendRedirect(encodedURL);
            }
            else{
                HttpSession session = req.getSession();
                req.setAttribute("userLoggedIn",u);
                session.setAttribute("username", user);
                session.setAttribute("roles", "normal");
                String encodedURL = resp.encodeRedirectURL("home.do");
                resp.sendRedirect(encodedURL);
            }
        }else{
            //HttpSession sess = req.getSession();
            //sess.invalidate();
            String encodedURL = resp.encodeRedirectURL("http://localhost:8080/projES/login.do?wrong_password");
            resp.sendRedirect(encodedURL);
        }

    }

    protected void doService(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}