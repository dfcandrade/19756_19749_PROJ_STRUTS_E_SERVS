package teste.servicos.section;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import teste.domain.*;
import teste.domain.dao.DaoFactory;
import teste.servicepack.security.logic.HasRole;
import teste.servicepack.security.logic.Transaction;
import teste.servicepack.security.logic.isAuthenticated;
import teste.servicos.paginas.ServicoPagina;
import teste.utils.HibernateUtils;

public class ServiceSection {
    private static final Logger logger = Logger.getLogger(ServiceSection.class);

    @isAuthenticated
    @HasRole(role = "admin")
    @Transaction
    public JSONObject addSection(JSONObject section) {
        logger.info("ENTREI---NA---CENA---DA---SECTION---PARA---ADICIONAR---");
        long idPage = section.getLong("idPage");
        Page page = DaoFactory.createPageDao().load(idPage);
        SectionImpl obj = SectionImpl.fromJson(section);

        if(obj.getId() > 0) {
            SectionImpl objPersistent = (SectionImpl) DaoFactory.createSectionDao().get(obj.getId());
            objPersistent.setId(obj.getId());
            objPersistent.setTitulo(obj.getTitulo());
            objPersistent.setPage(obj.getPage());
            JSONObject jsonObject = new JSONObject(objPersistent.toJson());

            return jsonObject;
        } else {
            page.getSections().add(obj);
            HibernateUtils.getCurrentSession().save(obj);
        }

        return new JSONObject(obj.toJson());
    }

    @isAuthenticated
    @Transaction
    public JSONArray returnAll(JSONObject dummy) throws JSONException {

        Page page = DaoFactory.createPageDao().load(dummy.getLong("id"));
        JSONArray resultados = new JSONArray();
        for(Section s: page.getSections())
        {
            for(Component c : s.getComponents()){
                resultados.put(new JSONObject(((ComponentImpl)c).toJson()));
            }
        }
        return resultados;
    }

    @isAuthenticated
    @HasRole(role = "admin")
    @Transaction
    public void deleteSection(JSONObject section) {
        Section s = (Section) HibernateUtils.getCurrentSession().load(Section.class, section.getLong("idSection"));

        HibernateUtils.getCurrentSession().delete(s);
    }
}
