package teste.domain;
// Generated 28/fev/2021 17:18:41 by Hibernate Tools 3.2.0.b9



/**
 * UserSession generated by hbm2java
 */
public abstract class UserSession  implements java.io.Serializable {


     private String cookie;
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
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }




}


