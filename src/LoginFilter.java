import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/*
* 登录过滤类，继承Servlet的Filter接口，实现访问页面前过滤未登录用户，保护数据
* */
public class LoginFilter implements javax.servlet.Filter {

//    重写销毁方法
    public void destroy(){

    }

    public void doFilter (ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest=(HttpServletRequest)servletRequest;
        HttpServletResponse httpServletResponse=(HttpServletResponse)servletResponse;
        String username = (String) httpServletRequest.getSession().getAttribute("username");
        if(null != username) {
            filterChain.doFilter(servletRequest,servletResponse);
        } else {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/login.jsp");
        }
    }
    public void init(FilterConfig filterConfig ) {

    }

}
