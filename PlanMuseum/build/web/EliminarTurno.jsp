<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Turno</title>
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
            int id_turno=Integer.parseInt(request.getParameter("idturno"));
            ps=connection.prepareStatement("delete from turno where id_turno="+ id_turno);
            ps.executeUpdate();
            response.sendRedirect("Turno.jsp");
        %>
    </body>
</html>
