<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>PlanMuseum</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/fontello.css">
        <link rel="stylesheet" type="text/css" href="css/estilos.css">
    </head>
    
    <body background="img/index.png">
        <%
            Connection connection=null;
            Statement statement=null;
            ResultSet resultSet=null;
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
            resultSet=statement.executeQuery("select * from museo");
        %>
        <header>
            <div class="contenedor">
                <img src="img/PMLogo.png">
                <h1>PlanMuseum</h1>
                <input type='checkbox' id="menu-bar">
                <label class="icon-menu" for="menu-bar"></label>
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
        <main>
            <section id="banner">
                <img src="banner/banner01.png">
                <div class="contenedor">
                    <h2>Bienvenido a Plan Museum</h2>
                    <p>Una página creada para almacenar diferentes museos y generar visitas guiadas</p>
                   
                </div>
            </section>
            <section id="bienvenidos">
                <h2>Museos</h2>
                <p>Estos son los museos disponibles</p>
            </section>
            <section id="blog">
                <div class="contenedor">
                <%
                while (resultSet.next()){
                %>
                   <article>
                       <a href="museoSeleccionado.jsp?idmuseo=<%= resultSet.getInt("id_museo")%>"> <img src="perfil/<%= resultSet.getString("nombre_banner")%>" alt="img/LogoPM.png" onerror="this.onerror=null;this.src=this.alt;"> </a>
                       <h4><%= resultSet.getString("nombre_museo")%></h4>
                   </article>
                <%}%>
                </div>
            </section>
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
