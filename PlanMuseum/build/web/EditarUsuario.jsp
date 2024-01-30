<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Usuario</title>
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
            int id_usuario=Integer.parseInt(request.getParameter("idusuario"));
            resultSet=statement.executeQuery("Select * from usuario where id_usuario="+id_usuario);
            while(resultSet.next()){           
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
            <h2>Ingrese los datos a modificar</h2>
            
            <form action="" method="POST">
                
                <div>
                <label for="ID"> ID :</label>
                <input id="ID" type="text" readonly="" name="txtIdUsuario" required value="<%= resultSet.getInt("id_usuario")%>"/>
                </div>
                <div>
                <label for="nombre"> Usuario :</label>
                <input id="nombre" type="text" name="txtUser" required value="<%= resultSet.getString("username")%>"/>
                </div>
                <div>
                <label for="email"> Email :</label>
                <input id="email" type="text" name="txtEmail" required value="<%= resultSet.getString("email")%>"/>
                </div>
                <div>
                <label for="contraseña"> Contraseña :</label>
                <input id="contraseña" type="password" name="txtPass" required value="<%= resultSet.getString("password")%>"/>
                </div>
                <input type="submit" value="Ingresar"/>
                <button onclick="location.href='Usuario.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
    </body>
</html>
<%          
    request.setCharacterEncoding("UTF-8");
    String username=request.getParameter("txtUser");
    String email=request.getParameter("txtEmail");
    String password=request.getParameter("txtPass");
    if(username!=null && email!=null && password!=null){
        statement.executeUpdate("update usuario set username='" + username + "',email='" + email + "',password='" + password + "'where id_usuario="+id_usuario);
        response.sendRedirect("Usuario.jsp");                
    }
%>
