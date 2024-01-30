<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Menu</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <link href="css/fontello.css" rel="stylesheet" type="text/css"/>
  
    <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    <body background="img/index.png">
        <%
            Connection connection=null;
            Statement statement=null;
            Statement statement2=null;
            ResultSet resultSet=null;
            ResultSet resultSet2=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            statement2=connection.createStatement();
            int id_museo=Integer.parseInt(request.getParameter("idmuseo"));
            resultSet=statement.executeQuery("Select museo.NOMBRE_MUSEO, area.nombre_area, museo.CALLE, museo.ALTURA, museo.DESCRIPCION, museo.NOMBRE_BANNER from museo inner join area on museo.ID_AREA=area.ID_AREA where id_museo="+id_museo);
            resultSet2=statement2.executeQuery("select imagen.NOMBRE_IMAGEN, museo.ID_MUSEO from imagen inner join museo on imagen.ID_MUSEO=MUSEO.ID_MUSEO where museo.id_museo="+id_museo);
            while (resultSet.next()){
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
                    <a href="Usuario.jsp">Usuario</a>
                </nav>
            </div>
        </header>
        <main>
            <section id="banner">
                <img src="banner/<%= resultSet.getString("nombre_banner")%>" alt="banner/banner01.png" onerror="this.onerror=null;this.src=this.alt;">

                <div class="contenedor">
                    <h2>Bienvenido a <%= resultSet.getString("nombre_museo")%></h2>
                    <h3>Direccion: <%= resultSet.getString("calle")%> <%= resultSet.getString("altura")%></h3>
                </div>
            </section>
            <section id="blog">
                <div class="contenedor">
                    <h2 style="text-align: center;">Somos un museo orientado a <%= resultSet.getString("nombre_area")%></h2>
                </div>
                    </section>
                    <section id="blog">
                        <div class="contenedor">
                    <h3 style="text-align: left;"><%= resultSet.getString("descripcion")%></h3>
                        </div>
                    </section>
                    <section id="blog">
                        <div class="contenedor">
                    <% while (resultSet2.next()){
                        
                    %>
                       <img src="img/<%= resultSet2.getString("nombre_imagen")%>" alt="banner/banner01.png"/> 
                    <%}%>
                    </div>
                    </section>
                
            <section id="info">
                <h3>¿Qué desea saber?</h3>
                <div class="contenedor">
                    <div class="info-museo">
                        <a href="museoExhibicion.jsp?idmuseo=<%= id_museo%>"> <img src="img/LogoPM.png" alt=""> </a>
                        <h4>Exhibiciones</h4>
                    </div>


                    <div class="info-museo">
                        <a href="AltaTurno.jsp?idmuseo=<%= id_museo%>"> <img src="img/LogoPM.png" alt=""> </a>
                        <h4>Turnos</h4>
                    </div>

                    
                </div>
                
            </section>
        <%}%>
        </main>
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
