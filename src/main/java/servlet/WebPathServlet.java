package servlet;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

/**
 * 需将Tomcat中将deployment的Application Context设置为空
 */
@WebServlet(urlPatterns = {},loadOnStartup = 2)
public class WebPathServlet extends HttpServlet {

    public void init(ServletConfig config)throws ServletException{
        //在整体应用上下文当中存储一个ctx的值，用它来引用上下文路径
        config.getServletContext().setAttribute("ctx",config.getServletContext().getContextPath());
        super.init(config);
    }

}
