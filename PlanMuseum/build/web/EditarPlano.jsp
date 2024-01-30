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
            int id_plano=Integer.parseInt(request.getParameter("idplano"));
            int id_museotest=Integer.parseInt(request.getParameter("idmuseo"));
            resultSet3=statement3.executeQuery("Select * from museo where id_museo="+id_museotest);
            resultSet=statement.executeQuery("Select * from plano where id_plano="+id_plano);
            resultSet2=statement2.executeQuery("Select * from museo where id_museo!="+id_museotest);
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
            <form action="EditarPlanoServlet" method="POST" enctype="multipart/form-data">
                <div>
                <label for="ID">ID :</label>
                <input id="ID" type="text" readonly="" name="txtIdPlano" required value="<%= resultSet.getInt("id_plano")%>"/>
                </div>
                <div>
                <label for="museo">Museo :</label>
                <select id="museo" name="IdMuseo">
                <% while (resultSet3.next()){    
                     int idMuseo = resultSet3.getInt("id_museo");   
                     String nombreMuseo = resultSet3.getString("nombre_museo");   
                %>
                    
                    <option value=<%= idMuseo%>><%= nombreMuseo%></option>
                <%}%>
                <% while (resultSet2.next()){    
                     int idMuseo = resultSet2.getInt("id_museo");   
                     String nombreMuseo = resultSet2.getString("nombre_museo");   
                %>
                    
                    <option value=<%= idMuseo%>><%= nombreMuseo%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="plano">Plano :</label>
                <input id="plano" type="file" name="file">
                </div>
                <input type="submit" value="Ingresar">
                <button onclick="location.href='Plano.jsp'" type="button">Volver</button>
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

%>