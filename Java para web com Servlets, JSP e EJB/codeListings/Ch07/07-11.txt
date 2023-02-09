import java.io.*;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.util.Enumeration;

public class ResponseFilter implements Filter {
  private FilterConfig filterConfig = null;
  public void destroy() {
    System.out.println("Filter destroyed");
    this.filterConfig = null;
  }
  
  public void doFilter(ServletRequest request, ServletResponse response,
    FilterChain chain)
    throws IOException, ServletException {
    System.out.println("doFilter");
    PrintWriter out = response.getWriter();
    // this is added to the beginning of the PrintWriter    
    out.println("<HTML>");
    out.println("<BODY>");
    out.println("<CENTER>");
    out.println("Page header");
    out.println("<HR>");



    chain.doFilter(request, response);
    // this is added to the end of the PrintWriter    
    out.println("<HR>");
    out.println("Page footer");
    out.println("<CENTER>");
    out.println("</BODY>");
    out.println("</HTML>");
  }

  public void init(FilterConfig filterConfig) throws ServletException {
    System.out.println("Filter initialized");
    this.filterConfig = filterConfig;
  }
}
