<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Imagen</title>
    </head>
    <body>
        <%
            String nombre_img="";
            Connection connection=null;
            Statement statement=null;
            ResultSet resultSet=null;
            PreparedStatement ps;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();          
            int id_imagen=Integer.parseInt(request.getParameter("idimg"));
            resultSet=statement.executeQuery("SELECT * from imagen where id_imagen="+id_imagen);
            String directorio=getServletContext().getRealPath("/img");
            if (resultSet.next()){
                nombre_img=resultSet.getString("nombre_imagen");
            }
            String ruta=directorio+ File.separator + nombre_img;
            File file=new File(ruta);
            if (file.exists()){
                file.delete();
            }
            ps=connection.prepareStatement("delete from imagen where id_imagen="+ id_imagen);
            ps.executeUpdate();
            response.sendRedirect("Imagen.jsp");
        %>
    </body>
</html>
