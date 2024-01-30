<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Turno</title> 
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
            resultSet=statement.executeQuery("SELECT plano.ID_PLANO, museo.NOMBRE_MUSEO, plano.NOMBRE_PLANO, plano.RUTA, museo.ID_MUSEO from plano inner join museo on plano.ID_MUSEO=museo.ID_MUSEO");
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
            <caption>Planos</caption>
            <caption><div><a href="AltaPlano.jsp">Agregar Plano</a></div></caption>
            <caption><div><a href="Museo.jsp">Ver Museos</a></div></caption>
            
            <thead>
                <tr>
                    <th>ID_PLANO</th>
                    <th>MUSEO</th>
                    <th>NOMBRE</th>                                                         
                    <th>ACCIONES</th>
                </tr>
            </thead>
            <tbody>
                <%
                   while (resultSet.next()){
                   
                    
                %>
                <tr>
                    <td data-label="ID_PLANO" ><%= resultSet.getInt("id_plano")%></td>
                    <td data-label="MUSEO" ><%= resultSet.getString("nombre_museo")%></td>
                    <td data-label="NOMBRE" ><%= resultSet.getString("nombre_plano")%></td>

                    <td style="visibility:collapse; display:none;"><%= resultSet.getString("id_museo")%></td>
                    <td data-label="ACCIONES" >
                        <div><a href="EditarPlano.jsp?idplano=<%= resultSet.getInt("id_plano")%>&idmuseo=<%= resultSet.getInt("id_museo")%>">Editar</a></div>
                        <div><a href="EliminarPlano.jsp?idplano=<%= resultSet.getInt("id_plano")%>&ruta=<%= resultSet.getString("ruta")%>">Eliminar</a></div>                       
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
