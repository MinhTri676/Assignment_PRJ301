/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.RankDAO;
import java.util.List;
import model.Rank;

/**
 *
 * @author caomi
 */
public class RankService {

    private final RankDAO dao = new RankDAO();

    public List<Rank> getAll() {
        return dao.getListAll();
    }
}
