package teste.servicos.logout;

import teste.domain.UserSession;
import teste.domain.dao.DaoFactory;
import teste.servicepack.security.logic.*;
import java.util.List;

public class ServiceLogout {

    @isAuthenticated
    @Transaction
    @injectSession
    public void logout(UserSession session) {
                session.setUser(null);
    }
}
