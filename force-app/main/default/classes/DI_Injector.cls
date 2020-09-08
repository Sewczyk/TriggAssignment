public class DI_Injector {
    public static Object instantiate(String className){
        Type t = Type.forName(className);
        return t.newInstance();
    }
}
