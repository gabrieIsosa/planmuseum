<%@page import="java.math.BigInteger"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cargar Turno</title>
        <link rel="stylesheet" type="text/css" href="css/formulario.css">
        <link rel="stylesheet" type="text/css" href="css/fontello.css">
    </head>
    <body>
        <%
            int id_museo2=0;
            Connection connection=null;
            Statement statement=null;
            Statement statement2=null;
            Statement statement3=null;
            ResultSet resultSet=null;
            ResultSet resultSet2=null;
            ResultSet resultSet3=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            statement2=connection.createStatement();
            statement3=connection.createStatement();
            resultSet=statement.executeQuery("Select * from museo");
            String idMuseo2=request.getParameter("idmuseo");
            if (idMuseo2!=null){
                id_museo2=Integer.parseInt(idMuseo2);
            }
            resultSet2=statement2.executeQuery("Select * from museo where id_museo="+id_museo2);
            resultSet3=statement3.executeQuery("Select * from usuario");
            if (id_museo2==0){
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
            <h2>Ingrese los datos del Turno</h2>
            <form action="" method="POST">
                <div>
                <label for="usuario">Usuario :</label> 
                <select id="usuario" name="IdUsuario">
                <% while (resultSet3.next()){    
                     int idUsuario = resultSet3.getInt("id_usuario");   
                     String nombreUsuario = resultSet3.getString("username");   
                %>                   
                    <option value=<%= idUsuario%>><%= nombreUsuario%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="fecha">Fecha : </label>
                <input id="fecha" type="date" name="fecha" required>
                </div>
                <div>
                <label for="hora">Hora:</label>
                <input id="hora" type="time" name="hora" required>
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
                <button onclick="location.href='Turno.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
        <%
            if(id_museo2!=0){
        %>
        <header>
            <div class="contenedor">
                <img src="img/PMLogo.png">
                <a href="index.jsp"><h1>PlanMuseum</h1></a>
                <input type='checkbox' id="menu-bar">
                <label class="icon-menu"for="menu-bar"></label>
                <nav class="menu">
                    <a href="index.html">Inicio</a>
                    <a href="Area.jsp"><h3>Area</h3></a>
                    <a href="Museo.jsp"><h3>Museo</h3></a>
                    <a href="Seccion.jsp"><h3>Seccion</h3></a>
                    <a href="Usuario.jsp"><h3>Usuarios</h3></a>
                    <a href="Beacon.jsp"><h3>Beacon</h3></a>
                    <a href="Turno.jsp"><h3>Turno</h3></a>
                </nav>
            </div>
        </header>
        <div id="formulario">
            <h2>Ingrese los datos del Turno</h2>
            
            <form action="" method="POST">
                <div>
                <label for="usuario">Usuario:</label>
                <select id="usuario" name="IdUsuario">
                <% while (resultSet3.next()){    
                     int idUsuario = resultSet3.getInt("id_usuario");   
                     String nombreUsuario = resultSet3.getString("username");   
                %>                   
                    <option value=<%= idUsuario%>><%= nombreUsuario%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="fecha">Fecha :</label>
                <input id="fecha" type="date" name="fecha" required>
                </div>
                <div>
                <label for="hora">Hora :</label>
                <input id="hora" type="time" name="hora" required>
                </div>
                <div>
                <label for="museo">Museo:</label>
                <select id="museo" name="IdMuseo">
                <% while (resultSet2.next()){    
                     int idMuseo = resultSet2.getInt("id_museo");   
                     String nombreMuseo = resultSet2.getString("nombre_museo");   
                %>
                    <option value=<%= idMuseo%>><%= nombreMuseo%></option>
                <%}%>
                </select>
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Turno.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
    </body>
</html>
<%
    int idUsuario=0;
    int idMuseo=0;
    String fecha=request.getParameter("fecha");
    String hora=request.getParameter("hora");
    String id_Usuario=request.getParameter("IdUsuario");
    String id_Museo=request.getParameter("IdMuseo");
    if(id_Usuario!=null){
        idUsuario=Integer.parseInt(id_Usuario);
    } 
    if(id_Museo!=null){
        idMuseo=Integer.parseInt(id_Museo);
    } 
    if(id_Usuario!=null && fecha!=null && hora!=null && id_Museo!=null){
        statement.executeUpdate("insert into turno (id_usuario,fecha,hora,id_museo) values ("+ idUsuario +",'" + fecha + "','" + hora + "',"+ idMuseo + ")");
        response.sendRedirect("Turno.jsp");
    }
%>
