import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class ResponseFilteredServlet extends HttpServlet {

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    out.println("<BR>Please enter your details.");
    out.println("<BR>");
    out.println("<BR><FORM METHOD=POST>");
    out.println("<TABLE>");
    out.println("<TR>");
    out.println("<TD>First Name:</TD>");
    out.println("<TD><INPUT TYPE=TEXT NAME=firstName></TD>");
    out.println("</TR>");
    out.println("<TR>");
    out.println("<TD>Last Name:</TD>");
    out.println("<TD><INPUT TYPE=TEXT NAME=lastName></TD>");
    out.println("</TR>");
    out.println("<TR>");
    out.println("<TD>User Name:</TD>");
    out.println("<TD><INPUT TYPE=TEXT NAME=userName></TD>");
    out.println("</TR>");
    out.println("<TR>");
    out.println("<TD>Password:</TD>");
    out.println("<TD><INPUT TYPE=PASSWORD NAME=password></TD>");
    out.println("</TR>");
    out.println("<TR>");
    out.println("<TD ALIGN=RIGHT COLSPAN=2>");
    out.println("<INPUT TYPE=SUBMIT VALUE=Login></TD>");
    out.println("</TR>");
    out.println("</TABLE>");
    out.println("</FORM>");
  }

}
