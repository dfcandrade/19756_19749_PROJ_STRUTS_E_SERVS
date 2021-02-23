package teste.domain;
// Generated 23/fev/2021 4:09:29 by Hibernate Tools 3.2.0.b9


import java.util.Date;

/**
 * UserSession generated by hbm2java
 */
public abstract class UserSession extends DomainObject implements java.io.Serializable {


     private String cookie;
     private Date updateDate;
     private Date saveDate;
     private User user;

    public UserSession() {
    }

	
    public UserSession(String cookie) {
        this.cookie = cookie;
    }
   
    public String getCookie() {
        return this.cookie;
    }
    
    public void setCookie(String cookie) {
        this.cookie = cookie;
    }
    public Date getUpdateDate() {
        return this.updateDate;
    }
    
    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }
    public Date getSaveDate() {
        return this.saveDate;
    }
    
    public void setSaveDate(Date saveDate) {
        this.saveDate = saveDate;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }




}


