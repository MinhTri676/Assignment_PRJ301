package service;

import constant.MessageConstant;
import dal.AccountDAO;
import dto.Response;
import java.util.Date;
import java.util.List;
import model.Account;

public class AccountService {

    AccountDAO accountDAO;

    public AccountService() {
        accountDAO = new AccountDAO();
    }

    public Response<Account> checkLogin(String account, String password) {
        Account a = accountDAO.checkLogin(account, password);
        if (a != null) {
            return new Response<Account>(a, true);
        } else {
            return new Response<Account>(null, false);
        }
    }

    public List<Account> loadAllAccount() {
        List<Account> list = accountDAO.getListAll();
        return list;
    }

    public void addAccount(Account obj) {
        accountDAO.insert(obj);
    }

    public void delete(String account) {
        Account a = accountDAO.getObjById(account);
        if (a != null) {
            accountDAO.delete(a);
        }
    }

    public Account getAccount(String account) {
        Account a = accountDAO.getObjById(account);
        if (a != null) {
            return a;
        } else {
            return null;
        }
    }

    public void updateAccount(Account obj) {
        accountDAO.update(obj);
    }

    public static void main(String[] args) {
        Date date = new Date(2004, 06, 01);
        Account account = new Account("admin1", "abc", "Cao Minh", "Trí", date, true, "0964638722", true, 1);
        AccountService a = new AccountService();
        a.updateAccount(account);
    }
}
