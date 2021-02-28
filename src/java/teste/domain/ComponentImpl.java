package teste.domain;

import com.owlike.genson.Genson;
import com.owlike.genson.GensonBuilder;
import org.json.JSONObject;

public class ComponentImpl extends Component {
    static Genson genson = new GensonBuilder()
            .useMethods(true)
            .useFields(false)
            .exclude(Object.class)
            .useClassMetadata(true)
            .useRuntimeType(true)
            .include("id", Component.class)
            .include("texto",Component.class)
            .include("imgDir",Component.class)
            .include("idSection",Component.class)
            .create();

    public static ComponentImpl fromJson(JSONObject jsonObject) {
        return genson.deserialize(jsonObject.toString(), ComponentImpl.class);
    }

    public String toJson() {
        return genson.serialize(this);
    }

    @Override
    public String toString() {
        return "Component{" +
                "id=" + getId() +
                ",texto='" + getTexto() +
                ",imgDir='" + getImgDir() +
                ",idSection='" + getSection().getId()+
                '}';
    }
}
