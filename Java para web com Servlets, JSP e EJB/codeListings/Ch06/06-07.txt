import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class PageCounterServlet extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out.println("<HTML>");
    out.println("<HEAD>");
    out.println("<TITLE>Page Counter</TITLE>");
    out.println("</HEAD>");
    out.println("<BODY>");
    ServletContext servletContext = getServletContext();
    int pageCounter = Integer.parseInt((String) 
      servletContext.getAttribute("pageCounter"));
    pageCounter++;
    out.println("You are visitor number " + pageCounter);
    servletContext.setAttribute("pageCounter", 
      Integer.toString(pageCounter));

    out.println("</BODY>");
    out.println("</HTML>");
  }
}
