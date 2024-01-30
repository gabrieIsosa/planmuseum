<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modificar Area</title>
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
            int id_area=Integer.parseInt(request.getParameter("idarea"));
            resultSet=statement.executeQuery("Select * from area where id_area="+id_area);
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
                <label for="nombreID">Id Area:</label>
                <input id="nombreID" type="text"readonly="" name="txtArea" required value="<%= resultSet.getInt("id_area")%>"/>
                </div>
                <div>
                <label for="nombreArea">Nombre:</label> 
                <input id="nombreArea" type="text" placeholder="Nombre"  name="txtNombreArea" required value="<%= resultSet.getString("nombre_area")%>"/>
                </div>
                <input type="submit" value="Ingresar"/>
                <button onclick="location.href='Area.jsp'" type="button">Volver</button>
            </form>
        <%}%>
        </div>
    </body>
</html>
<%
    String nombreArea=request.getParameter("txtNombreArea");
    if(nombreArea!=null){
        statement.executeUpdate("update area set nombre_area='" + nombreArea + "' where id_area="+id_area);
        response.sendRedirect("Area.jsp");
    }

%>
