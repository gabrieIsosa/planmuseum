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
            int id_seccion2=0;
            Connection connection=null;
            Statement statement=null;
            Statement statement2=null;
            ResultSet resultSet=null;
            ResultSet resultSet2=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            statement2=connection.createStatement();
            resultSet=statement.executeQuery("Select * from seccion");
            String idSeccion2=request.getParameter("idseccion");
            if (idSeccion2!=null){
                id_seccion2=Integer.parseInt(idSeccion2);
            }
            resultSet2=statement2.executeQuery("Select * from seccion where id_seccion="+id_seccion2);
            if (id_seccion2==0){
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
            <h2>Ingrese los datos del Beacon</h2>
            <form action="" method="POST">
                
                <div>
                <label for="ID"> UID :</label>
                <input id="ID" type="text" name="txtUID" required>
                </div>
                <div>
                <label for="seccion">Sección :</label>
                <select id="seccion" name="IdSeccion">
                <% while (resultSet.next()){    
                     int idSeccion = resultSet.getInt("id_seccion");   
                     String nombreSeccion = resultSet.getString("nombre_seccion");   
                %>
                    
                    <option value=<%= idSeccion%>><%= nombreSeccion%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="descripcion"> Descripción :</label>
                <input id="descripcion" type="text" name="txtDesc" required>
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Beacon.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
        <%
            if(id_seccion2!=0){
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
            <h2>Ingrese los datos del Beacon</h2>
            
            <form action="" method="POST">
                <div>
                <label for="ID"> UID :</label>
                <input id="ID" type="text" name="txtUID" required>
                </div>
                <div>
                <label for="seccion">Sección :</label>
                <select id="seccion" name="IdSeccion">
                <% while (resultSet2.next()){    
                     int idSeccion = resultSet2.getInt("id_seccion");   
                     String nombreSeccion = resultSet2.getString("nombre_seccion");   
                %>
                    
                    <option value=<%= idSeccion%>><%= nombreSeccion%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="descripcion"> Descripcion :</label>
                <input id="descripcion" type="text" name="txtDesc" required>
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Seccion.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
    </body>
</html>
<%
    int idSeccion=0;
    String uid=request.getParameter("txtUID");
    String id_Seccion=request.getParameter("IdSeccion");
    String desc=request.getParameter("txtDesc");
    if(id_Seccion!=null){
        idSeccion=Integer.parseInt(id_Seccion);
    } 
    if(uid!=null && id_Seccion!=null && desc!=null){
        statement.executeUpdate("insert into beacon (uid,id_seccion,descripcion) values ('"+ uid +"'," + idSeccion + ",'" + desc + "')");
        response.sendRedirect("Beacon.jsp");
    }
%>