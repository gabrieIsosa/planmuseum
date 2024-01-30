/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package paquetemuseo;

import java.io.*;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class MuseoImagen extends HttpServlet {
    Connection connection=null;
    Statement statement=null;
    ResultSet resultSet=null;
    public void init(ServletConfig config) throws ServletException{
        super.init(config);
        try{
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            connection=DriverManager.getConnection("jdbc:derby://localhost:1527/PlanMuseumBDD");
            statement=connection.createStatement();
        } catch (ClassNotFoundException ex) {
            System.out.println("No se pudo cargar el controlador: " + ex.getMessage());
        } catch (SQLException ex){
            System.out.println("Hubo un error en el SQL: " + ex.getMessage());
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
            /* TODO output your page here. You may use following sample code. */
            request.setCharacterEncoding("UTF-8");
            Part part=request.getPart("file");
            Part part2=request.getPart("file2");
            String nombre_museo=request.getParameter("txtNombreMuseo");
            int idArea=Integer.parseInt(request.getParameter("IdArea"));
            String calle=request.getParameter("txtCalle");
            String altura=request.getParameter("txtAltura");
            String descripcion=request.getParameter("txtDescripcion");
            String directorio=getServletContext().getRealPath("/banner");
            String directorio2=getServletContext().getRealPath("/perfil");
            String fileName=extractFileName(part);
            String fileName2=extractFileName(part2);
            String savepath= directorio + File.separator + fileName;
            String savepath2= directorio2 + File.separator + fileName2;
            File fileSaveDir = new File(savepath);
            File fileSaveDir2 = new File(savepath2);
            
            
            
            try{
                if(!fileName.equals("") && !fileName2.equals("")){
                    part.write(savepath + File.separator);
                    part2.write(savepath2 + File.separator);
                    statement.executeUpdate("insert into museo (nombre_museo,id_area,calle,altura,descripcion,banner,nombre_banner,perfil,nombre_perfil) values ('"+ nombre_museo +"'," + idArea + ",'" + calle + "','" + altura + "','" + descripcion + "','" + savepath + "','" + fileName + "','"+ savepath2 + "','"+fileName2+"')");
                    response.sendRedirect("Museo.jsp");
                }
                if(!fileName.equals("") && fileName2.equals("")){
                    part.write(savepath + File.separator);
                    statement.executeUpdate("insert into museo (nombre_museo,id_area,calle,altura,descripcion,banner,nombre_banner) values ('"+ nombre_museo +"'," + idArea + ",'" + calle + "','" + altura + "','" + descripcion + "','" + savepath + "','" + fileName + "')");
                    response.sendRedirect("Museo.jsp");
                }
                if(fileName.equals("") && !fileName2.equals("")){
                    part2.write(savepath2 + File.separator);
                    statement.executeUpdate("insert into museo (nombre_museo,id_area,calle,altura,descripcion,perfil,nombre_perfil) values ('"+ nombre_museo +"'," + idArea + ",'" + calle + "','" + altura + "','" + descripcion + "','" + savepath2 + "','" + fileName2 + "')");
                    response.sendRedirect("Museo.jsp");
                }
            } catch (SQLException ex) {
            out.println(ex);
        }
        }
    
    
    
    
    
    private String extractFileName(Part part){
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items){
            if (s.trim().startsWith("filename")){
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }


}
