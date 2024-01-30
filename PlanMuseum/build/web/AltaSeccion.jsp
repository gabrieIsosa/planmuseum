<%@page import="java.math.BigInteger"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cargar Seccion</title>
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
            resultSet=statement.executeQuery("Select * from museo");
            
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
            <h2>Ingrese los datos de la Seccion</h2>

            <form action="" method="POST">
                <div>
                <label for="nombre"> Nombre :</label>
                <input id="nombre" type="text" name="txtNombreSeccion" required>
                </div>
                <div>
                <label for="museo">Museo :</label>
                <select id="museo" name="IdMuseo">
                <% while (resultSet.next()){    
                     int idMuseo = resultSet.getInt("id_museo");   
                     String nombreMuseo = resultSet.getString("nombre_museo");   
                %>
                    
                    <option value=<%= idMuseo%>><%= nombreMuseo%></option>
                <%}%>
                </select>
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Seccion.jsp'" type="button">Volver</button>
            </form>
        </div>        
    </body>
</html>
<%
    int idMuseo=0;
    String nombreSeccion=request.getParameter("txtNombreSeccion");
    String id_Museo=request.getParameter("IdMuseo");
    if(id_Museo!=null){
        idMuseo=Integer.parseInt(id_Museo);
    } 
    if(nombreSeccion!=null && id_Museo!=null){
        statement.executeUpdate("insert into seccion (nombre_seccion,id_museo) values ('"+ nombreSeccion +"'," + idMuseo + ")");
        response.sendRedirect("Seccion.jsp");
    }
%>