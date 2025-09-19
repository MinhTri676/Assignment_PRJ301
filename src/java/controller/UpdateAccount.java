/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import constant.ParameterConstant;
import constant.URLConstant;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import service.AccountService;


@WebServlet(name = "UpdateAccount", urlPatterns = {"/updateAccount"})
public class UpdateAccount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService accountService = new AccountService();
        String account = request.getParameter("update");
        Account a = accountService.getAccount(account);
        request.setAttribute("info", a);
        request.getRequestDispatcher(URLConstant.UPDATE_ACCOUNT_URL).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountService accountService = new AccountService();
        String account = request.getParameter(ParameterConstant.ACCOUNT);
        String password = request.getParameter(ParameterConstant.PASSWORD);
        String lastName = request.getParameter(ParameterConstant.LASTNAME);
        String firstName = request.getParameter(ParameterConstant.FIRSTNAME);
        String birthday_raw = request.getParameter(ParameterConstant.BIRTHDAY);
        String gender_raw = request.getParameter(ParameterConstant.GENDER);
        String phone = request.getParameter(ParameterConstant.PHONE);
        String isUse_raw = request.getParameter(ParameterConstant.ISUSE);
        String role_raw = request.getParameter(ParameterConstant.ROLEINSYSTEM);
        try {
            boolean gender = false;
            boolean isUse;

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = formatter.parse(birthday_raw);

            if (gender_raw.equalsIgnoreCase("1")) {
                gender = true;
            }

            if (isUse_raw == null) {
                isUse = false;
            } else {
                isUse = true;
            }
            int role = Integer.parseInt(role_raw);
            accountService.updateAccount(new Account(account, password, lastName, firstName, date, gender, phone, isUse, role));
            response.sendRedirect(URLConstant.ACCOUNT_LIST_URL);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
