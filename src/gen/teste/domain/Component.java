package teste.domain;
// Generated 27/fev/2021 8:41:21 by Hibernate Tools 3.2.0.b9



/**
 * Component generated by hbm2java
 */
public abstract class Component  implements java.io.Serializable {


     private long id;
     private String texto;
     private String imgDir;
     private Section section;

    public Component() {
    }

   
    public long getId() {
        return this.id;
    }
    
    public void setId(long id) {
        this.id = id;
    }
    public String getTexto() {
        return this.texto;
    }
    
    public void setTexto(String texto) {
        this.texto = texto;
    }
    public String getImgDir() {
        return this.imgDir;
    }
    
    public void setImgDir(String imgDir) {
        this.imgDir = imgDir;
    }
    public Section getSection() {
        return this.section;
    }
    
    public void setSection(Section section) {
        this.section = section;
    }




}


