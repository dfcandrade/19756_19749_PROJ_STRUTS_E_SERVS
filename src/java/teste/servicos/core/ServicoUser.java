package teste.servicos.core;

import org.apache.log4j.Logger;
import org.hibernate.Transaction;
import org.hibernate.classic.Session;
import org.json.JSONArray;
import org.json.JSONObject;
import teste.domain.User;
import teste.domain.UserImpl;
import teste.domain.dao.DaoFactory;
//import teste.servicepack.security.logic.HasRole;
//import teste.servicepack.security.logic.Transaction;
//import teste.servicepack.security.logic.isAuthenticated;
import teste.utils.HibernateUtils;

import java.util.List;

public class ServicoUser {
    private static final Logger logger = Logger.getLogger(ServicoUser.class);

    Session sess = HibernateUtils.getCurrentSession();
    Transaction t = sess.beginTransaction();
    public JSONObject addUser(JSONObject user)
    {

        UserImpl userObj = UserImpl.fromJson(user);
        if(userObj.getId() > 0)
        {
                UserImpl objPersistente = (UserImpl)DaoFactory.createUserDao().get(userObj.getId());

                objPersistente.setNome(userObj.getNome());
                objPersistente.setUsername(userObj.getUsername());
                objPersistente.setPassword(userObj.getPassword());
                objPersistente.setEmail(userObj.getEmail());
                objPersistente.setRoles(userObj.getRoles());
                JSONObject jsonObject = new JSONObject(objPersistente.toJson());
                t.commit();
                return jsonObject;
        }
        else
        {
            sess.save(userObj);
        }
        t.commit();

        return new JSONObject(userObj.toJson());
    }

    public JSONObject loadUser(JSONObject idObj)
    {
        Session sess = HibernateUtils.getCurrentSession();
        Transaction t = sess.beginTransaction();


        Long id = idObj.getLong("id");

        UserImpl userPersistente = (UserImpl)DaoFactory.createUserDao().get(id);

        JSONObject jsonObject = new JSONObject(userPersistente.toJson());

        t.rollback();

        return jsonObject;

    }



    public JSONArray loadAll(JSONObject dummy)
    {
        Session sess = HibernateUtils.getCurrentSession();
        Transaction t = sess.beginTransaction();

        List<User> users = DaoFactory.createUserDao().createCriteria().list();

        JSONArray resultados = new JSONArray();
        for(User u: users)
        {
            resultados.put(new JSONObject(((UserImpl)u).toJson()));
        }

        t.rollback();

        return resultados;
    }
}
