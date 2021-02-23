package teste.domain;

import java.util.Date;

public abstract class DomainObject {

    public abstract void setSaveDate(Date d);

    public DomainObject(){
        setSaveDate(new Date());
    }

}
