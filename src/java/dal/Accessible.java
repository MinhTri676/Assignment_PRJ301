package dal;
import java.util.List;

public interface Accessible<T> {
    void insert(T obj);
    void update(T obj);
    void delete(T obj);
    T getObjById(String id);
    List<T> getListAll();
}
