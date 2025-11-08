/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author caomi
 */
public class Rank {
    private int rankID;
    private String rankName;
    private int point;
    private double voucher;

    public Rank() {
    }
    
    public Rank(int rankID, String rankName) {
        this.rankID = rankID;
        this.rankName = rankName;
    }
    public Rank(int rankID, String rankName, int point, double voucher) {
        this.rankID = rankID;
        this.rankName = rankName;
        this.point = point;
        this.voucher = voucher;
    }
    
    public int getRankID() {
        return rankID;
    }

    public void setRankID(int rankID) {
        this.rankID = rankID;
    }

    public String getRankName() {
        return rankName;
    }

    public void setRankName(String rankName) {
        this.rankName = rankName;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public double getVoucher() {
        return voucher;
    }

    public void setVoucher(double voucher) {
        this.voucher = voucher;
    }
}



