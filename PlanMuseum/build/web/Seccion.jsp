<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Seccion</title>  
        <link rel="stylesheet" type="text/css" href="css/tabla.css">
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
            resultSet=statement.executeQuery("SELECT seccion.id_seccion, seccion.nombre_seccion, museo.NOMBRE_MUSEO, museo.ID_MUSEO from seccion inner join museo on seccion.ID_MUSEO=museo.ID_MUSEO");
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
        <div class="contenedor">
            <table class=tabla>
                <caption>Seccion</caption>
                <caption><div><a href="AltaSeccion.jsp">Agregar Seccion</a></div></caption>
                <thead>
                <tr>
                    <th>ID_SECCION</th>
                    <th>NOMBRE</th>
                    <th>MUSEO</th>                    
                    <th>ACCIONES</th>
                </tr>
                </thead>
                <tbody>
                <%
                   while (resultSet.next()){
                   
                    
                %>
                <tr>
                    <td data-label="ID_SECCION" ><%= resultSet.getInt("id_seccion")%></td>
                    <td data-label="NOMBRE" ><%= resultSet.getString("nombre_seccion")%></td>
                    <td data-label="MUSEO" ><%= resultSet.getString("nombre_museo")%></td>
                    <td data-label="ACCIONES"  style="visibility:collapse; display:none;"><%= resultSet.getString("id_museo")%></td>
                    <td>
                        <div><a href="EditarSeccion.jsp?idseccion=<%= resultSet.getInt("id_seccion")%>&idmuseo=<%= resultSet.getInt("id_museo")%>">Editar</a></div>
                        <div><a href="EliminarSeccion.jsp?idseccion=<%= resultSet.getInt("id_seccion")%>">Eliminar</a></div>
                        <div><a href="AltaBeacon.jsp?idseccion=<%= resultSet.getInt("id_seccion")%>">Cargar Beacon</a></div>
                    </td>
                </tr>
                <%}%>
                </tbody>
            </table>       
        </div>
        <footer>
            <div class="contenedor">
                <p class="copy">PlanMuseum &copy; 2022</p>
                <div class="sociales">
                    <a class="icon-facebook" href="#"></a>
                    <a class="icon-Twitter" href="#"></a>
                    <a class="icon-instagram" href="#"></a>
                    <a class="icon-googleplus" href="#"></a>
                </div>
            </div>
        </footer>
    </body>
</html>
