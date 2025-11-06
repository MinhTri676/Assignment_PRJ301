/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package dao;

import java.util.List;

public interface Accessible<T> {
    boolean insert(T obj);
    boolean update(T obj);
    boolean delete(T obj);
    T getObjById(int id);
    List<T> getListAll();
}
