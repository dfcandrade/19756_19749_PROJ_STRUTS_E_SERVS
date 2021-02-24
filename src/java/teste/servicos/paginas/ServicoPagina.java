package teste.servicos.paginas;

import org.hibernate.Hibernate;
import org.json.JSONArray;
import org.json.JSONObject;
import teste.domain.Page;
import teste.domain.PageImpl;
import teste.domain.User;
import teste.domain.UserSession;
import teste.domain.dao.DaoFactory;
import teste.servicepack.security.SecurityContextProvider;
import teste.servicepack.security.logic.HasRole;
import teste.servicepack.security.logic.Transaction;
import teste.servicepack.security.logic.CriadorPagina;
import teste.servicepack.security.logic.isAuthenticated;
import teste.utils.HibernateUtils;

import java.util.List;

public class ServicoPagina {
    @isAuthenticated
    @Transaction
    @HasRole(role = "admin")
    @CriadorPagina
    public JSONObject addPage(JSONObject page) {
        PageImpl obj = PageImpl.fromJson(page);
        String cookie = SecurityContextProvider.getInstance().getSecuritySessionContext().getRequester();
        UserSession session = (UserSession) HibernateUtils.getCurrentSession().load(UserSession.class,cookie);

        if(obj.getId() > 0) {
            PageImpl objPersistent = (PageImpl) DaoFactory.createPageDao().get(obj.getId());

            objPersistent.setTitulo(obj.getTitulo());

            JSONObject jsonObject = new JSONObject(objPersistent.toJson());

            return jsonObject;
        } else {
            obj.setUser(session.getUser());
            HibernateUtils.getCurrentSession().save(obj);
            return new JSONObject(obj.toJson());
        }
    }

    @isAuthenticated
    @Transaction
    public JSONObject loadPage(JSONObject page) {
        Long objId = page.getLong("id");
        PageImpl objPersistent = (PageImpl) DaoFactory.createPageDao().get(objId);

        JSONObject jsonObject = new JSONObject(objPersistent.toJsonSingle());

        return jsonObject;
    }

    @isAuthenticated
    @Transaction
    public JSONArray loadAll(JSONObject dummy) {
        List<Page> pages = DaoFactory.createPageDao().createCriteria().list();
        JSONArray results = new JSONArray();

        for(Page p: pages) {
            results.put(new JSONObject(((PageImpl)p).toJson()));
        }

        return results;
    }

    @isAuthenticated
    @HasRole (role = "admin")
    @Transaction
    public void deletePage(JSONObject page) {
        Page p = (Page) HibernateUtils.getCurrentSession().load(Page.class, page.getLong("id"));

        HibernateUtils.getCurrentSession().delete(p);
    }
}
