<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cargar Area</title>
        <link rel="stylesheet" type="text/css" href="css/formulario.css">
        <link rel="stylesheet" type="text/css" href="css/fontello.css">
    </head>
    <body>
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
            <h2>Ingrese los datos del Area</h2>
            
            <form action="" method="POST">
                <div>
                <label for="nombre"> Usuario :</label>
                <input id="nombre" type="text" name="txtUser" required>
                </div>
                <div>
                <label for="email"> Email :</label>
                <input id="email" type="text" name="txtEmail" required>
                </div>
                <div>
                <label for="contraseña"> Contraseña :</label>
                <input id="contraseña" type="password" name="txtPass" required>
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Usuario.jsp'" type="button">Volver</button>
            </form>
        </div>        
    </body>
</html>
<%
            Connection connection=null;
            Statement statement=null;
            ResultSet resultSet=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            request.setCharacterEncoding("UTF-8");
            String username=request.getParameter("txtUser");
            String email=request.getParameter("txtEmail");
            String password=request.getParameter("txtPass");
            if(username!=null && email!=null && password!=null){
                statement.executeUpdate("insert into usuario (username,email,password) values ('" + username + "','" + email + "','" + password + "')");
                response.sendRedirect("Usuario.jsp");                
            }
%>