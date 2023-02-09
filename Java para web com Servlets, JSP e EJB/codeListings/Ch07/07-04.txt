import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class LoggingFilter implements Filter {
  private FilterConfig filterConfig = null;
  public void destroy() {
    System.out.println("Filter destroyed");
    this.filterConfig = null;
  }
  
  public void doFilter(ServletRequest request, ServletResponse response,
    FilterChain chain)
    throws IOException, ServletException {
    System.out.println("doFilter");
    
    // Log user's IP address.
    ServletContext servletContext = filterConfig.getServletContext();
    servletContext.log(request.getRemoteHost());
    chain.doFilter(request, response);
  }

  public void init(FilterConfig filterConfig) throws ServletException {
    System.out.println("Filter initialized");
    this.filterConfig = filterConfig;
  }
}
