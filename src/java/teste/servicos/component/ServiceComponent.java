package teste.servicos.component;

import org.json.JSONObject;
import teste.domain.Component;
import teste.domain.ComponentTextImpl;
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
    public JSONObject addComponentText(JSONObject component) {
        long idSection = component.getLong("idSection");
        Section section = DaoFactory.createSectionDao().load(idSection);
        ComponentTextImpl obj = ComponentTextImpl.fromJson(component.getJSONObject("c"));

        if(obj.getId()> 0) {
            ComponentTextImpl objPersistent = (ComponentTextImpl) DaoFactory.createComponentDao().get(obj.getId());

            objPersistent.setTexto(obj.getTexto());

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
