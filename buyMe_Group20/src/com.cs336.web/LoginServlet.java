package com.cs336.web;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cs336.bean.LoginBean;
import com.cs336.database.LoginDao;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LoginDao loginDao;

    public void init() {
        loginDao = new LoginDao();
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LoginBean loginBean = new LoginBean();
        loginBean.setUsername(username);
        loginBean.setPassword(password);

        try {
            if (loginDao.validate(loginBean)) {
                System.out.println("reached true validation");
                HttpSession session = request.getSession();
                session.setAttribute("username",username);
                response.sendRedirect("accountSettings.jsp");
                System.out.println("redirect accountSettings");
            } else {
                System.out.println("reached false validation");
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                response.sendRedirect("loginError.jsp");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
