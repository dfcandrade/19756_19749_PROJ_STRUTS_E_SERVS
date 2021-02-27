package teste.servicos.component;

import org.json.JSONObject;
import teste.domain.Component;
import teste.domain.ComponentImpl;
import teste.domain.Section;
import teste.domain.dao.DaoFactory;
import teste.servicepack.security.logic.HasRole;
import teste.servicepack.security.logic.Transaction;
import teste.servicepack.security.logic.isAuthenticated;
import teste.utils.HibernateUtils;

public class ServiceComponent {

    @isAuthenticated
    @HasRole(role="admin")
    @Transaction
    public JSONObject addComponent(JSONObject component) {
        long idSection = component.getLong("idSection");
        Section section = DaoFactory.createSectionDao().load(idSection);
        ComponentImpl obj = ComponentImpl.fromJson(component.getJSONObject("c"));

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
        Component c = (Component) HibernateUtils.getCurrentSession().load(Component.class, component.getLong("idComponent"));

        HibernateUtils.getCurrentSession().delete(c);
    }
}
