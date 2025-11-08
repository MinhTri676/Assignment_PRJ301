/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Rank;
import ultils.DBUtils;

/**
 *
 * @author caomi
 */
public class RankDAO implements Accessible<Rank> {

    @Override
    public boolean insert(Rank obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean update(Rank obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean delete(Rank obj) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Rank getObjById(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Rank> getListAll() {
        ArrayList<Rank> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();

            String sql = "SELECT * FROM CUSTOMER_RANK";

            PreparedStatement pst = conn.prepareStatement(sql);

            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Rank rank = new Rank();
                rank.setRankID(rs.getInt("RANK_ID"));
                rank.setRankName(rs.getNString("RANK_NAME"));
                rank.setPoint(rs.getInt("POINT"));
                rank.setVoucher(rs.getDouble("VOUCHER"));
                list.add(rank);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
