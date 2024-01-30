<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Turno</title>
        <link rel="stylesheet" type="text/css" href="css/formulario.css">
        <link rel="stylesheet" type="text/css" href="css/fontello.css">
    </head>
    <body>
        <%
            Connection connection=null;
            Statement statement=null;
            Statement statement2=null;
            Statement statement3=null;
            Statement statement4=null;
            Statement statement5=null;
            ResultSet resultSet=null;
            ResultSet resultSet2=null;
            ResultSet resultSet3=null;
            ResultSet resultSet4=null;
            ResultSet resultSet5=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            statement2=connection.createStatement();
            statement3=connection.createStatement();
            statement4=connection.createStatement();
            statement5=connection.createStatement();
            int id_turno=Integer.parseInt(request.getParameter("idturno"));
            int id_museotest=Integer.parseInt(request.getParameter("idmuseo"));
            int id_usertest=Integer.parseInt(request.getParameter("idusuario"));
            resultSet5=statement5.executeQuery("Select * from usuario where id_usuario!="+id_usertest);
            resultSet4=statement4.executeQuery("Select * from usuario where id_usuario="+id_usertest);
            resultSet3=statement3.executeQuery("Select * from museo where id_museo="+id_museotest);
            resultSet=statement.executeQuery("Select * from turno where id_turno="+id_turno);
            resultSet2=statement2.executeQuery("select * from museo where id_museo!="+id_museotest);
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
                <input id="ID" type="text" readonly="" name="txtIdTurno" required value="<%= resultSet.getInt("id_turno")%>"/>
                </div>
                <div>
                <label for="usuario">Usuario :</label>
                <select id="usuario" name="IdUsuario">
                <% while (resultSet4.next()){    
                     int idUsuario = resultSet4.getInt("id_usuario");   
                     String nombreUsuario = resultSet4.getString("username");   
                %>                   
                    <option value=<%= idUsuario%>><%= nombreUsuario%></option>
                <%}%>
                <% while (resultSet5.next()){    
                     int idUsuario = resultSet5.getInt("id_usuario");   
                     String nombreUsuario = resultSet5.getString("username");   
                %>                   
                    <option value=<%= idUsuario%>><%= nombreUsuario%></option>
                <%}%>
                </select>
                </div>
                <div>
                <label for="fecha">Fecha :</label>
                <input id="fecha" type="date" name="fecha" required value="<%= resultSet.getString("fecha")%>"/>
                </div>
                <div>
                <label for="hora">Hora :</label>
                <input id="hora" type="time" name="hora" required value="<%= resultSet.getString("hora")%>"/>
                </div>
                <div>
                <label for="museo">Museo:</label>
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
        statement.executeUpdate("update turno set id_usuario="+ idUsuario +",fecha='" + fecha + "',hora='" + hora + "',id_museo="+ idMuseo + "where id_turno="+id_turno);
        response.sendRedirect("Turno.jsp");
    }
%>
