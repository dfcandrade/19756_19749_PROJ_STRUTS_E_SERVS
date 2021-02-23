package teste.domain.dao;

import teste.domain.Component;

public class ComponentDao extends AbstractDao<Component> {
    private ComponentDao() {}

    private static ComponentDao instance = new ComponentDao();

    protected static ComponentDao getInstance() { return instance; }

    @Override
    public Class obtainDomainClass() {
        return Component.class;
    }
}
