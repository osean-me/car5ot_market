package carrot.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.MemberDTO;


//등록은 web.xml에 수행
public class TestLoginFilter implements Filter{
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
//		다운캐스팅
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		
		try {

			
//			1번 코드
			MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
			
//			2번 코드
			if(mdto == null) {//로그인 상태가 아니라면
				//3번 코드
				MemberDAO mdao = new MemberDAO();
				MemberDTO user = mdao.get("test");	//test1 아이디 확인

				//로그인
				req.getSession().setAttribute("memberinfo", user);
			}
			
			chain.doFilter(request, response);//통과
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}