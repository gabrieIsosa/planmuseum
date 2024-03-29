<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
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
            resultSet=statement.executeQuery("Select * from usuario");
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
                <caption>Usuarios</caption>
                <caption><div><a href="AltaUsuario.jsp">Agregar Usuario</a></div></caption>
            <thead>
                <tr>
                    <th>ID_USUARIO</th>
                    <th>NOMBRE DE USUARIO</th>
                    <th>EMAIL</th>
                    <th>CONTRASEÑA</th>
                    <th>ACCIONES</th>
                </tr>
                </thead>
                <tbody>
                <%
                   while (resultSet.next()){
                   
                    
                %>
                <tr>
                    <td data-label="ID_USUARIO"  ><%= resultSet.getInt("id_usuario")%></td>
                    <td data-label="NOMBRE DE USUARIO"  ><%= resultSet.getString("username")%></td>
                    <td data-label="EMAIL"  ><%= resultSet.getString("email")%></td>
                    <td data-label="CONTRASEÑA"  ><%= resultSet.getString("password")%></td>
                    <td data-label="ACCIONES"  >
                        <div><a href="EditarUsuario.jsp?idusuario=<%= resultSet.getInt("id_usuario")%>">Editar</a></div>
                        <div><a href="EliminarUsuario.jsp?idusuario=<%= resultSet.getInt("id_usuario")%>">Eliminar</a></div>
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