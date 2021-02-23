package teste.domain.dao;

import teste.domain.ComponentText;

public class ComponentTextDao extends AbstractDao<ComponentText>{


    private ComponentTextDao() {
    }

    private static ComponentTextDao instance = new ComponentTextDao();

    protected static ComponentTextDao getInstance()
    {
        return instance;
    }

    @Override
    public Class obtainDomainClass() {
        return  ComponentText.class;
    }

}
