import javax.servlet.ServletContext;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextAttributeEvent;
import java.io.*;

public class AppAttributeEventDemo 
  implements ServletContextListener, ServletContextAttributeListener {

  int counter;
  String counterFilePath = "C:\\counter.txt";

  public void contextInitialized(ServletContextEvent cse) {
    try {
      BufferedReader reader = new 
        BufferedReader(new FileReader(counterFilePath));
      counter = Integer.parseInt( reader.readLine() );
      reader.close();
       System.out.println("Reading" + counter);
       
    }
    catch (Exception e) {
       System.out.println(e.toString());
    }

    ServletContext servletContext = cse.getServletContext();

    servletContext.setAttribute("pageCounter", Integer.toString(counter));
    System.out.println("Application initialized");
  }

  public void contextDestroyed(ServletContextEvent cse) {
    System.out.println("Application shut down");
  }

  public void attributeAdded(ServletContextAttributeEvent scae) {
    System.out.println("ServletContext attribute added");
  }

  public void attributeRemoved(ServletContextAttributeEvent scae) {
    System.out.println("ServletContext attribute removed");
  }

  
  public void attributeReplaced(ServletContextAttributeEvent scae) {
    System.out.println("ServletContext attribute replaced");
    writeCounter(scae);
  }

  synchronized void writeCounter(ServletContextAttributeEvent scae) {
    ServletContext servletContext = scae.getServletContext();

    counter = Integer.parseInt((String) 
      servletContext.getAttribute("pageCounter"));

    try {
      BufferedWriter writer = new 
        BufferedWriter(new FileWriter(counterFilePath));
      writer.write(Integer.toString(counter));
      writer.close();
       System.out.println("Writing");
    }
    catch (Exception e) {
       System.out.println(e.toString());
    }

  }
}
