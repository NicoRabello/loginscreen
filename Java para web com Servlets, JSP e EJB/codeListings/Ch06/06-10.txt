import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class UserCounterServlet extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
    ServletContext servletContext = getServletContext();
    HttpSession session = request.getSession(true);
    int userCounter = 0;
    userCounter = 
      Integer.parseInt((String)servletContext.getAttribute("userCounter"));

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out.println("<HTML>");
    out.println("<HEAD>");
    out.println("<TITLE>User Counter</TITLE>");
    out.println("</HEAD>");
    out.println("<BODY>");
    
    out.println("There are " + userCounter + " users.");
    out.println("</BODY>");
    out.println("</HTML>");
  }
}
