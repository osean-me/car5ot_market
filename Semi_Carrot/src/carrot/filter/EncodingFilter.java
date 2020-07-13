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

//이 필터의 목적은 모든 요청을 UTF-8로 복원하는 것
// - 감시할 주소 : 전체(/*)

//@WebFilter(urlPatterns = "/*")
public class EncodingFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		//사용자가 보낸 데이터를 UTF-8로 복원
		
		//필터에서 주어지는 request와 response는 상위버전 형태로 보관되므로 다운캐스팅하여 사용한다(무조건!)
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		req.setCharacterEncoding("UTF-8");
		
		//chain은 사용자의 요청과 관련된 모든 도구들의 연결정보
		// - doFilter 명령을 내리면 가던길 가라는 뜻
		// - request는 원래의 요청 정보(HttpServletRequest의 상위버전)
		// - response는 원래의 응답 정보(HttpServletResponse의 상위버전)
		chain.doFilter(request, response);
	}
}
