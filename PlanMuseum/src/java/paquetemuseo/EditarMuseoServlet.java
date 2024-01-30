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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
public class EditarMuseoServlet extends HttpServlet {
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
            String nombre_banner="";
            String nombre_perfil="";
            request.setCharacterEncoding("UTF-8");
            Part part=request.getPart("file");     
            Part part2=request.getPart("file2");     
            String nombre_museo=request.getParameter("txtNombreMuseo");
            int idArea=Integer.parseInt(request.getParameter("IdArea"));
            int idMuseo=Integer.parseInt(request.getParameter("txtIdMuseo"));
            String calle=request.getParameter("txtCalle");
            String altura=request.getParameter("txtAltura");
            String descripcion=request.getParameter("txtDescripcion");
            String directorio=getServletContext().getRealPath("/banner");
            String directorio2=getServletContext().getRealPath("/perfil");
        try {
            resultSet=statement.executeQuery("SELECT * from museo where id_museo="+idMuseo);
            if (resultSet.next()){
                nombre_banner=resultSet.getString("nombre_banner");
                nombre_perfil=resultSet.getString("nombre_perfil");
            }
            String fileName=extractFileName(part);
            String fileName2=extractFileName(part2);
            String savepath= directorio + File.separator + fileName;
            String savepath2= directorio2 + File.separator + fileName2;
            File fileSaveDir = new File(savepath);
            File fileSaveDir2 = new File(savepath2);
            String ruta=directorio+ File.separator + nombre_banner;
            String ruta2=directorio2+ File.separator + nombre_perfil;
            File file=new File(ruta);
            File file2=new File(ruta2);
            
            if(!fileName.equals("") && !fileName2.equals("")){
                    if (file.exists()){
                        file.delete();
                    }
                    if (file2.exists()){
                        file2.delete();
                    }
                    part.write(savepath + File.separator);
                    part2.write(savepath2 + File.separator);
                    statement.executeUpdate("update museo set nombre_museo='"+ nombre_museo +"',id_area=" + idArea + ",calle='" + calle + "',altura='" + altura + "',descripcion='" + descripcion + "',banner='" + savepath + "',nombre_banner='" + fileName + "',perfil='"+ savepath2 + "',nombre_perfil='"+fileName2+"' where id_museo="+idMuseo);
                    response.sendRedirect("Museo.jsp");
                }
                if(!fileName.equals("") && fileName2.equals("")){
                    if (file.exists()){
                        file.delete();
                    }
                    part.write(savepath + File.separator);
                    statement.executeUpdate("update museo set nombre_museo='"+ nombre_museo +"',id_area=" + idArea + ",calle='" + calle + "',altura='" + altura + "',descripcion='" + descripcion + "',banner='" + savepath + "',nombre_banner='" + fileName + "' where id_museo="+idMuseo);
                    response.sendRedirect("Museo.jsp");
                }
                if(fileName.equals("") && !fileName2.equals("")){
                    if (file2.exists()){
                        file2.delete();
                    }
                    part2.write(savepath2 + File.separator);
                    statement.executeUpdate("update museo set nombre_museo='"+ nombre_museo +"',id_area=" + idArea + ",calle='" + calle + "',altura='" + altura + "',descripcion='" + descripcion + "',perfil='" + savepath2 + "',nombre_perfil='" + fileName2 + "' where id_museo="+idMuseo);
                    response.sendRedirect("Museo.jsp");
                }
                if(fileName.equals("") && fileName2.equals("")){
                    statement.executeUpdate("update museo set nombre_museo='"+ nombre_museo +"',id_area=" + idArea + ",calle='" + calle + "',altura='" + altura + "',descripcion='" + descripcion +  "' where id_museo="+idMuseo);
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
