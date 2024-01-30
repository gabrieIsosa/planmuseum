<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Menu</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="css/fontello.css" rel="stylesheet" type="text/css"/>
        <link href="css/estilos2.css" rel="stylesheet" type="text/css"/>
        <link href="css/tabla.css" rel="stylesheet" type="text/css"/>
    </head>

    <body background="img/index.png">
        <%
            int id_beacon=0;
            String desc="";
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
            int id_museo=Integer.parseInt(request.getParameter("idmuseo"));
            String idBeacon=request.getParameter("idbeac");
            if (idBeacon!=null){
                id_beacon=Integer.parseInt(idBeacon);
            }
            resultSet=statement.executeQuery("select * from seccion where id_museo="+id_museo);
            resultSet2=statement2.executeQuery("select * from plano where id_museo="+id_museo);
            resultSet4=statement4.executeQuery("Select museo.NOMBRE_MUSEO, area.nombre_area, museo.CALLE, museo.ALTURA, museo.DESCRIPCION, museo.NOMBRE_BANNER from museo inner join area on museo.ID_AREA=area.ID_AREA where id_museo="+id_museo);
            resultSet5=statement5.executeQuery("select * from beacon where id_beacon="+id_beacon);
            
        %>
        <script>
            window.speechSynthesis.cancel();
        </script>
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
            <%while (resultSet4.next()){%>
            <section id="banner">
                <img align="middle" src="banner/<%= resultSet4.getString("nombre_banner")%>" alt="banner/banner01.png" onerror="this.onerror=null;this.src=this.alt;">

                <div class="contenedor">
                    <h2>Visita Guiada de <%= resultSet4.getString("nombre_museo")%></h2>
                </div>
         <%}%>
            </section>
            <section id="blog">
                <div class="contenedor">
                    <h1>Plano del Museo</h1>
                </div>
            </section>
            <section id="blog">
                <div class="contenedor">
                    <p>
                <% while (resultSet2.next()){
                        
                    %>
                    <center><img src="planos/<%= resultSet2.getString("nombre_plano")%>" alt="banner/banner01.png"/></center>
                        
                    <%}%>
                </div>
            </section>
            <section id="blog"> 
                <div class="contenedor">
                    
            <table class=tabla>
                <thead>
                <tr>
                    <th>SECCION</th>
                    <th>ACCION</th>
                </tr>
                </thead>
                <tbody>
                <%
                   while (resultSet.next()){
                    int id_seccion=resultSet.getInt("id_seccion");
                    resultSet3=statement3.executeQuery("select * from beacon where id_seccion="+id_seccion);
                    if (resultSet3.next()){
                        
                    
                    
                %>
                
                <tr>
                    <td data-label="SECCION" ><%= resultSet.getString("nombre_seccion")%></td>
                    <td style="visibility:collapse; display:none;"><%= resultSet3.getString("descripcion")%></td>
                    <td data-label="ACCION" >
                        <div><a href="museoExhibicion.jsp?idmuseo=<%= id_museo%>&idbeac=<%= resultSet3.getInt("id_beacon")%>">Reproducir</a></div>
                    </td>
                </tr>
                    <%}%>
                <%}%>
                </tbody>
            </table>       
        </div>
            </section>
            <%
            while (resultSet5.next()){
                desc=resultSet5.getString("descripcion");
            }
            %>
            <script>
                    var msg = new SpeechSynthesisUtterance();
                    var desc ="<%=desc%>"; 
                    msg.text = desc;
                    window.speechSynthesis.speak(msg);
                   
           </script>
    
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
