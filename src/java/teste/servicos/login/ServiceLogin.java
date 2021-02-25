package teste.servicos.login;

import teste.domain.User;
import teste.domain.UserSession;
import teste.domain.dao.DaoFactory;
import teste.servicepack.security.logic.Transaction;
import teste.servicepack.security.logic.injectSession;

import javax.servlet.ServletException;
import java.io.IOException;
import java.util.List;

public class ServiceLogin {

    User u = null;

    @Transaction
    @injectSession
    public boolean checkLogin(String username,String password, UserSession session) throws ServletException, IOException {

        List<User> users = DaoFactory.createUserDao().createCriteria().list();

        for (User value : users) {
            if (value.getUsername().equals(username) && value.getPassword().equals(password)) {
                System.out.println(session.getCookie());
                u = value;
                session.setUser(value);
                return true;
            }
        }
        return false;
    }

    @Transaction
    public String returnRole(){
        return u.getRoles();
    }

}
