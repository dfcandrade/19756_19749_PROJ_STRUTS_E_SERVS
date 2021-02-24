package teste.domain.dao;

public class DaoFactory
{

    public static UserDao createUserDao() {return UserDao.getInstance(); }
    public static UserSessionDao createUserSessionDao() { return UserSessionDao.getInstance(); }
    public static PageDao createPageDao() { return PageDao.getInstance(); }
    public static SectionDao createSectionDao() { return SectionDao.getInstance(); }
    public static ComponentDao createComponentDao() { return ComponentDao.getInstance(); }

}
