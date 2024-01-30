<%@page import="java.math.BigInteger"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cargar Museo</title>
        <link rel="stylesheet" type="text/css" href="css/formulario.css">
        <link rel="stylesheet" type="text/css" href="css/fontello.css">
    </head>
    <body>
        <%
            Connection connection=null;
            Statement statement=null;
            ResultSet resultSet=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            resultSet=statement.executeQuery("Select * from area");
            
        %>
        <header>
            <div class="contenedor">
                <img src="img/PMLogo.png">
                <a href="index.jsp"><h1>PlanMuseum</h1></a>
                <input type='checkbox' id="menu-bar">
                <label class="icon-menu"for="menu-bar"></label>
                <nav class="menu">
                    <a href="index.jsp">Inicio</a>
                    <a href="Area.jsp">Area</a>
                    <a href="Museo.jsp">Museo</a>
                    <a href="Seccion.jsp">Seccion</a>
                    <a href="Beacon.jsp">Beacon</a>
                    <a href="Turno.jsp">Turno</a>
                    <a href="Plano.jsp">Planos</a>
                    <a href="Imagen.jsp">Imagen</a>
                    <a href="Usuario.jsp">Usuario</a>
                </nav>
            </div>
        </header>
        <div id="formulario">
            <h2>Ingrese los datos del Museo</h2>
            
            <form action="MuseoImagen" method="POST" enctype="multipart/form-data">
                <div>
                <label for="nombre">Nombre :</label>
                <input id="nombre" type="text" name="txtNombreMuseo" required>
                </div>
                <div>
                <label for="area">Area :</label>
                <select id="area" name="IdArea">
                <% while (resultSet.next()){    
                     int idArea = resultSet.getInt("id_area");   
                     String nombreArea = resultSet.getString("nombre_area");   
                %>
                    
                    <option value=<%= idArea%>><%= nombreArea%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="calle">Calle :</label>
                <input id="calle" type="text" name="txtCalle" required>
                </div>
                <div>
                <label for="altura">Altura :</label>
                <input id="altura" type="text" name="txtAltura" required>
                </div>
                <div>
                <label for="descripcion">Descripción :</label>
                <input id="descripcion" type="text" name="txtDescripcion" required>
                </div>
                <div>
                <label for="banner">Icono :</label>
                <input id="banner" type="file" name="file2" >
                </div>
                <div>
                <label for="banner">Banner :</label>
                <input id="banner" type="file" name="file" >
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Museo.jsp'" type="button">Volver</button>
            </form>
        </div>        
    </body>
</html>
<%
    int idArea=0;
    String nombreMuseo=request.getParameter("txtNombreMuseo");
    String id_Area=request.getParameter("IdArea");
    if(id_Area!=null){
        idArea=Integer.parseInt(id_Area);
    } 
    String calle=request.getParameter("txtCalle");
    String altura=request.getParameter("txtAltura");
    String descripcion=request.getParameter("txtDescripcion");
    if(nombreMuseo!=null && id_Area!=null && calle!=null && altura!=null && descripcion!=null){
        statement.executeUpdate("insert into museo (nombre_museo,id_area,calle,altura,descripcion) values ('"+ nombreMuseo +"'," + idArea + ",'" + calle + "','" + altura + "','" + descripcion + "')");
        response.sendRedirect("Museo.jsp");
    }
%>