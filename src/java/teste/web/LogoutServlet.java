package teste.web;

import org.apache.log4j.Logger;
import teste.domain.User;
import teste.domain.UserSession;
import teste.servicos.logout.ServiceLogout;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LogoutServlet extends AbstractServlet {
    private static final Logger logger = Logger.getLogger(LogoutServlet.class);
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logger.info("LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT---LOGOUT");
        HttpSession session = req.getSession();
        //String user = req.getParameter("username");
        ServiceLogout servLogout = new ServiceLogout();
        servLogout.logout(null);
        session.setAttribute("isLoggedIn", false);
        String encodedURL = resp.encodeRedirectURL("http://localhost:8080/projES/login.do");
        resp.sendRedirect(encodedURL);
    }

    @Override
    protected void doService(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
