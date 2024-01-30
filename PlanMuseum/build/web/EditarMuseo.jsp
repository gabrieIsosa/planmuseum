<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Museo</title>
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
            int id_museo=Integer.parseInt(request.getParameter("idmuseo"));
            int id_areatest=Integer.parseInt(request.getParameter("idarea"));
            resultSet3=statement3.executeQuery("Select * from area where id_area="+id_areatest);
            resultSet=statement.executeQuery("Select * from museo where id_museo="+id_museo);
            resultSet2=statement2.executeQuery("Select * from area where id_area!="+id_areatest);
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
            
            <form action="EditarMuseoServlet" method="POST" enctype="multipart/form-data">
                <div>
                <label for="ID">ID :</label>
                <input id="ID" type="text" readonly="" name="txtIdMuseo" required value="<%= resultSet.getInt("id_museo")%>"/>
                </div>
                <div>
                <label for="nombre">Nombre:</label>
                <input id="nombre" type="text" name="txtNombreMuseo" required value="<%= resultSet.getString("nombre_museo")%>"/>
                </div>
                <div>
                <label for="area">Area :</label>
                <select id="area" name="IdArea">
                <% while (resultSet3.next()){    
                     int idArea = resultSet3.getInt("id_area");   
                     String nombreArea = resultSet3.getString("nombre_area");   
                %>
                    
                    <option value=<%= idArea%>><%= nombreArea%></option>
                <%}%>
                <% while (resultSet2.next()){    
                     int idArea = resultSet2.getInt("id_area");   
                     String nombreArea = resultSet2.getString("nombre_area");   
                %>
                    
                    <option value=<%= idArea%>><%= nombreArea%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="calle">Calle :</label>
                <input id="calle" type="text" name="txtCalle" required value="<%= resultSet.getString("calle")%>"/>
                </div>
                <div>
                <label for="altura">altura :</label>
                <input id="altura" type="text" name="txtAltura" required value="<%= resultSet.getString("altura")%>"/>
                </div>
                <div>
                <label for="descripcion">Descripción :</label>
                <input id="descripcion" type="text" name="txtDescripcion" required value="<%= resultSet.getString("descripcion")%>"/>
                </div>
                <div>
                <label for="banner">Icono :</label>
                <input id="banner" type="file" name="file2" >
                </div>
                <div>
                <label for="banner">Banner :</label>
                <input id="banner" type="file" name="file" >
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Museo.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
    </body>
</html>
<%
    int idArea=0;
    String nombreMuseo=request.getParameter("txtNombreMuseo");
    String id_Area=request.getParameter("IdArea");
    if(id_Area!=null){
        idArea=Integer.parseInt(id_Area);
    } 
    String calle=request.getParameter("txtCalle");
    String altura=request.getParameter("txtAltura");
    String descripcion=request.getParameter("txtDescripcion");
    if(nombreMuseo!=null && id_Area!=null && calle!=null && altura!=null && descripcion!=null){
        statement.executeUpdate("update museo set nombre_museo='"+ nombreMuseo +"',id_area=" + idArea + ",calle='" + calle + "',altura='" + altura + "',descripcion='" + descripcion + "'where id_museo="+ id_museo);
        response.sendRedirect("Museo.jsp");
    }
%>