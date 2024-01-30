<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Museo</title>
    </head>
    <body>
        <%
            Connection connection=null;
            Statement statement=null;
            ResultSet resultSet=null;
            PreparedStatement ps;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            int id_seccion=Integer.parseInt(request.getParameter("idseccion"));
            ps=connection.prepareStatement("delete from seccion where id_seccion="+ id_seccion);
            ps.executeUpdate();
            response.sendRedirect("Seccion.jsp");
        %>
    </body>
</html>
