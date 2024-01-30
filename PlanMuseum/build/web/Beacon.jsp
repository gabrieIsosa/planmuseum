<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Beacon</title>
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
            resultSet=statement.executeQuery("SELECT beacon.ID_BEACON, beacon.uid, seccion.NOMBRE_SECCION, beacon.DESCRIPCION, seccion.ID_SECCION from beacon inner join seccion on beacon.ID_SECCION=SECCION.ID_SECCION");
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
            <caption>Beacon</caption>
            <caption><div><a href="AltaBeacon.jsp">Agregar Beacon</a></div></caption>
            <caption><div><a href="Seccion.jsp">Ver Secciones</a></div></caption>
            <thead>
                <tr>
                    <th>ID_BEACON</th>
                    <th>UID</th>
                    <th>SECCION</th>                    
                    <th>DESCRIPCION</th>                    
                    <th>ACCIONES</th>
                </tr>
                </thead>
                <tbody>
                <%
                   while (resultSet.next()){
                    
                %>
                <tr>
                    <td data-label="ID_BEACON"><%= resultSet.getInt("id_beacon")%></td>
                    <td data-label="UID"><%= resultSet.getString("uid")%></td>
                    <td data-label="SECCION"><%= resultSet.getString("nombre_seccion")%></td>
                    <td data-label="DESCRIPCION"><%= resultSet.getString("descripcion")%></td>
                    <td style="visibility:collapse; display:none;"><%= resultSet.getInt("id_seccion")%></td>
                    <td data-label="ACCIONES">
                        <div><a href="EditarBeacon.jsp?idbeacon=<%= resultSet.getInt("id_beacon")%>&idseccion=<%= resultSet.getInt("id_seccion")%>">Editar</a></div>
                        <div><a href="EliminarBeacon.jsp?idbeacon=<%= resultSet.getInt("id_beacon")%>">Eliminar</a></div>                       
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
