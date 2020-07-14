package carrot.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dto.MemberDTO;


public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

				
		HttpServletRequest req =(HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		
		MemberDTO mdto = (MemberDTO)req.getSession().getAttribute("memberinfo");
		
		boolean isLogin =mdto!=null;
		
		if(isLogin) {
			chain.doFilter(request, response);
		}
		else {
			resp.sendRedirect(req.getContextPath()+"/user/login.jsp");
		}
	}
}
