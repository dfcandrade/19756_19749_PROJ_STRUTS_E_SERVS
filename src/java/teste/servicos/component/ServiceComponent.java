package teste.servicos.component;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import teste.domain.Component;
import teste.domain.ComponentImpl;
import teste.domain.Page;
import teste.domain.Section;
import teste.domain.dao.DaoFactory;
import teste.servicepack.security.logic.HasRole;
import teste.servicepack.security.logic.Transaction;
import teste.servicepack.security.logic.isAuthenticated;
import teste.servicos.section.ServiceSection;
import teste.utils.HibernateUtils;

public class ServiceComponent {
    private static final Logger logger = Logger.getLogger(ServiceComponent.class);
    @isAuthenticated
    @HasRole(role="admin")
    @Transaction
    public JSONObject addComponent(JSONObject component) {
        logger.info("---ENTREI---NA---CENA---DO---COMPONENT---");
        long idSection = component.getLong("idSection");
        ComponentImpl obj = ComponentImpl.fromJson(component);
        Section section = DaoFactory.createSectionDao().load(idSection);

        if(obj.getId()> 0) {
            ComponentImpl objPersistent = (ComponentImpl) DaoFactory.createComponentDao().get(obj.getId());
            objPersistent.setId(obj.getId());
            objPersistent.setSection(obj.getSection());
            objPersistent.setTexto(obj.getTexto());
            objPersistent.setImgDir(obj.getImgDir());
            JSONObject jsonObject = new JSONObject(objPersistent.toJson());

            return jsonObject;
        } else {
            section.getComponents().add(obj);
            HibernateUtils.getCurrentSession().save(obj);
        }

        return new JSONObject(obj.toJson());
    }


    @isAuthenticated
    @HasRole(role="admin")
    @Transaction
    public void deleteComponent(JSONObject component) {
        Component c = (Component) HibernateUtils.getCurrentSession().load(Component.class, component.getLong("id"));

        HibernateUtils.getCurrentSession().delete(c);
    }
}
