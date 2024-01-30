<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Plano</title>
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
            int id_plano=Integer.parseInt(request.getParameter("idplano"));
            String ruta=request.getParameter("ruta");
            File file=new File(ruta);
            if (file.exists()){
                file.delete();
            }
            ps=connection.prepareStatement("delete from plano where id_plano="+ id_plano);
            ps.executeUpdate();
            response.sendRedirect("Plano.jsp");
        %>
    </body>
</html>
