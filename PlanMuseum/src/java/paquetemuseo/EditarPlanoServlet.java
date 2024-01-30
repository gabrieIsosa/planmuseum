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
public class EditarPlanoServlet extends HttpServlet {
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

            int idMuseo=Integer.parseInt(request.getParameter("IdMuseo"));
            int idPlano=Integer.parseInt(request.getParameter("txtIdPlano"));
            Part part=request.getPart("file");
            String fileName=extractFileName(part);
            String directorio=getServletContext().getRealPath("/planos");
            String savepath=directorio + File.separator + fileName;
            File fileSaveDir = new File(savepath);
            part.write(savepath + File.separator);
            
            try{
                statement.executeUpdate("update plano set id_museo="+ idMuseo +",nombre_plano='" + fileName + "',ruta='" + savepath + "'where id_plano="+idPlano);
                response.sendRedirect("Plano.jsp");
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
