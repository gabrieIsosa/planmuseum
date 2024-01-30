<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0; text/html; charset=UTF-8" >
        <title>Museo</title>
        <link rel="stylesheet" type="text/css" href="css/tabla.css">
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
            resultSet=statement.executeQuery("SELECT museo.ID_MUSEO, museo.NOMBRE_MUSEO, area.NOMBRE_AREA, museo.CALLE, museo.ALTURA, museo.DESCRIPCION, area.ID_AREA, museo.BANNER from museo inner join area on museo.ID_AREA=area.ID_AREA");
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
        <div class="contenedor">
		<table class=tabla>
			<caption>Museos</caption>
                        <caption><div><a href="AltaMuseo.jsp">Agregar Museo</a></div></caption>

			<thead>
				<tr>
					<th>ID_MUSEO</th>
                                        <th>NOMBRE</th>
                                        <th>AREA</th>
                                        <th>CALLE</th>
                                        <th>ALTURA</th>
                                        <th>DESCRIPCION</th>
                                        <th>ACCIONES</th>
				</tr>
			</thead>
                    <tbody>
                <%
                   while (resultSet.next()){
                   
                    
                %>
                
				<tr>
                                    <td data-label="ID_MUSEO" ><%= resultSet.getInt("id_museo")%></td>
                                    <td data-label="NOMBRE" ><%= resultSet.getString("nombre_museo")%></td>
                                    <td data-label="AREA" ><%= resultSet.getString("nombre_area")%></td>
                                    <td data-label="CALLE" ><%= resultSet.getString("calle")%></td>
                                    <td data-label="ALTURA" ><%= resultSet.getString("altura")%></td>
                                    <td data-label="DESCRIPCION" ><%= resultSet.getString("descripcion")%></td>
                                    <td style="visibility:collapse; display:none;"><%= resultSet.getString("id_area")%></td>
                                    <td style="visibility:collapse; display:none;"><%= resultSet.getString("banner")%></td>
                                    <td data-label="ACCIONES" >
                                        <div><a href="EditarMuseo.jsp?idmuseo=<%= resultSet.getInt("id_museo")%>&idarea=<%= resultSet.getInt("id_area")%>">Editar</a></div>
                                        <div><a href="EliminarMuseo.jsp?idmuseo=<%= resultSet.getInt("id_museo")%>&ruta=<%= resultSet.getString("banner")%>">Eliminar</a></div>
                                            <div><a href="AltaPlano.jsp?idmuseo=<%= resultSet.getInt("id_museo")%>">Cargar Plano</a></div>
                                        <div><a href="AltaImagen.jsp?idmuseo=<%= resultSet.getInt("id_museo")%>">Cargar Imagenes</a></div>
                                        
                                    </td>
                                </tr>
                        <%}%>
                </tbody>
            </table>       
        </div>
            <footer>
            <div class="contenedor">
                <p class="copy">PlanMuseum &copy; 2022</p>
                <div class="sociales">
                    <a class="icon-facebook" href="#"></a>
                    <a class="icon-Twitter" href="#"></a>
                    <a class="icon-instagram" href="#"></a>
                    <a class="icon-googleplus" href="#"></a>
                </div>
            </div>
        </footer>   
    </body>
</html>
