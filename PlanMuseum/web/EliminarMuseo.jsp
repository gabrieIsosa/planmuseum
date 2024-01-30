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
            String nombre_banner="";
            String nombre_perfil="";
            Connection connection=null;
            Statement statement=null;
            ResultSet resultSet=null;
            PreparedStatement ps;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            int id_museo=Integer.parseInt(request.getParameter("idmuseo"));
            resultSet=statement.executeQuery("SELECT * from museo where id_museo="+id_museo);
            String directorio=getServletContext().getRealPath("/banner");
            String directorio2=getServletContext().getRealPath("/perfil");
            if (resultSet.next()){
                nombre_banner=resultSet.getString("nombre_banner");
                nombre_perfil=resultSet.getString("nombre_perfil");
            }
            String ruta=directorio+ File.separator + nombre_banner;
            String ruta2=directorio2+ File.separator + nombre_perfil;
            File file=new File(ruta2);
            File file2=new File(ruta);
            if (file.exists()){
                file.delete();
            }
            
            if (file2.exists()){
                file2.delete();
            }
            ps=connection.prepareStatement("delete from museo where id_museo="+ id_museo);
            ps.executeUpdate();
            response.sendRedirect("Museo.jsp");
        %>
    </body>
</html>
