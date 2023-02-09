import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class FilteredServlet extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out.println("<HTML>");
    out.println("<HEAD>");
    out.println("<TITLE>User Counter</TITLE>");
    out.println("</HEAD>");
    out.println("<BODY>");
    out.println("IP:" + request.getRemoteHost());
    out.println("</BODY>");
    out.println("</HTML>");
  }
}
