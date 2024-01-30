<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Beacon</title>
        <link rel="stylesheet" type="text/css" href="css/formulario.css">
        <link rel="stylesheet" type="text/css" href="css/fontello.css">
    </head>
    <body>
        <%
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
            int id_beacon=Integer.parseInt(request.getParameter("idbeacon"));
            int id_secciontest=Integer.parseInt(request.getParameter("idseccion"));
            resultSet3=statement3.executeQuery("Select * from seccion where id_seccion="+id_secciontest);
            resultSet=statement.executeQuery("Select * from beacon where id_beacon="+id_beacon);
            resultSet2=statement2.executeQuery("select * from seccion where id_seccion!="+id_secciontest);
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
                <input id="ID" type="text" readonly="" name="txtIdBeacon" required value="<%= resultSet.getInt("id_beacon")%>"/>
                </div>
                <div>
                <label for="UID">UID :</label>
                <input id="UID" type="text" name="txtUid" required value="<%= resultSet.getString("uid")%>"/>
                </div>
                <div>
                <label for="seccion">Sección :</label>
                <select id="seccion" name="IdSeccion">
                <% while (resultSet3.next()){    
                     int idSeccion = resultSet3.getInt("id_seccion");   
                     String nombreSeccion = resultSet3.getString("nombre_seccion");   
                %>
                    
                    <option value=<%= idSeccion%>><%= nombreSeccion%></option>
                <%}%>
                <% while (resultSet2.next()){    
                     int idSeccion = resultSet2.getInt("id_seccion");   
                     String nombreSeccion = resultSet2.getString("nombre_seccion");   
                %>
                    
                    <option value=<%= idSeccion%>><%= nombreSeccion%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="descripcion"> Descripción :</label>
                <input id="descripcion" type="text" name="txtDesc" required value="<%= resultSet.getString("descripcion")%>"/>
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Beacon.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
    </body>
</html>
<%
    int idSeccion=0;
    String uid=request.getParameter("txtUid");
    String id_Seccion=request.getParameter("IdSeccion");
    String desc=request.getParameter("txtDesc");
    if(id_Seccion!=null){
        idSeccion=Integer.parseInt(id_Seccion);
    } 
    if(uid!=null && id_Seccion!=null && desc!=null){
        statement.executeUpdate("update beacon set uid='"+ uid +"',id_seccion=" + idSeccion + ",descripcion='" + desc + "' where id_beacon="+id_beacon);
        response.sendRedirect("Beacon.jsp");
    }
%>