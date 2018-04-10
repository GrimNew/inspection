<%--
  Created by IntelliJ IDEA.
  User: Grim
  Date: 2017-11-22
  Time: 21:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>铁路信号巡检系统 - 登录检验</title>
</head>
<body>
<%
    String username=request.getParameter("username");
    String password=request.getParameter("password");
    boolean loggedIn=false;
%>

<%!
    private static final String url=
            "jdbc:mysql://localhost:3306/inspect" +    //JDBC方式/MySQL数据库/本机/端口3306/数据库名称
                    "?useSSL=false&useUnicode=true&characterEncoding=utf8"; //SSL关闭/使用Unicode编码/编码方式utf-8
    private static final String dbuser="root";
    private static final String dbpassword="root";
    private Connection connection;
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");   //反射加载驱动
        connection = DriverManager.getConnection(url,dbuser,dbpassword);  //数据库连接实例化
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }

    //创建对象
    Statement statement = null;
    ResultSet resultSet = null;
    try {
        statement = connection.createStatement();//对象实例化
        resultSet = statement.executeQuery("SELECT * FROM user_table WHERE username=\'"+username+"\' AND password=\'"+password+"\'");//对象实例化，完成SQL语句执行
        if (resultSet.next()){//next()方法返回数据库返回值
            if(resultSet.getBoolean("is_admin")){
                loggedIn=true;
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    //关闭相关资源
    try {
        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        connection.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if(loggedIn){
        request.getSession().setAttribute("username", username);
        response.sendRedirect("info.jsp");
    }else{
        response.sendRedirect("loginerror.jsp");
    }
%>
</body>
</html>
