<%--
  Created by IntelliJ IDEA.
  User: Grim
  Date: 2017-11-24
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/theme.css" type="text/css">
    <title>铁路信号巡检系统 - 信息查看</title>
    <%!
        private static final String url=
                "jdbc:mysql://localhost:3306/inspect" +    //JDBC方式/MySQL数据库/本机/端口3306/数据库名称
                        "?useSSL=false&useUnicode=true&characterEncoding=utf8"; //SSL关闭/使用Unicode编码/编码方式utf-8
        private static final String dbuser="root";
        private static final String dbpassword="root";
        private Connection connection;
    %>
</head>
<body class="">
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");   //反射加载驱动
        connection = DriverManager.getConnection(url,dbuser,dbpassword);  //数据库连接实例化
        if (connection == null){
            out.println("异常：数据库连接失败！<br>");
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
%>
<div class="border border-light h-100 py-5 opaque-overlay" style="background-image: url(image/backgroundImage.jpg);">
    <div class="container"><div class="row"><div class="col-lg-12"><div class="row"><div class="col-lg-12"><div class="row">
        <div class="col-lg-2"></div>
        <div class="col-lg-8 opaque-overlay"><h1 class="text-center text-light">巡检动态信息表</h1></div>
        <div class="col-lg-2"></div>
    </div></div></div><div class="row"><div class="col-lg-12"><div class="row">
        <div class="col-lg-2"></div>
        <div class="col-lg-8 text-light opaque-overlay"><table class="table text-light">
            <%
                Statement statement = null;
                ResultSet resultSet = null;
                try {
                    statement = connection.createStatement();
                    resultSet = statement.executeQuery("SELECT * FROM data_table");
            %>
            <thead>
            <tr class="text-light">
                <th>设备编号</th>
                <th>设备人员</th>
                <th>巡检时间</th>
                <th>设备状态</th>
            </tr>
            </thead>
            <tbody>
            <%
                    while (resultSet.next()){
            %>
            <tr>
                <td><%=resultSet.getString(1)%></td>
                <td><%=resultSet.getString(2)%></td>
                <td><%=resultSet.getTimestamp(3)%></td>
                <td><%=resultSet.getString(4)%></td>
            </tr>
            <%
                    }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            %>
            </tbody>
        </table></div>
        <div class="col-lg-2"></div>
    </div></div></div></div></div></div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>

<%
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
%>
</body>
</html>