package carrot.servlet.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.MemberDTO;



	public class loginServlert extends HttpServlet{
		@Override
		protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
try {
	req.setCharacterEncoding("UTF-8");
	MemberDTO mdto =new MemberDTO();
	mdto.setMember_id(req.getParameter("member_id"));
	mdto.setMember_pw(req.getParameter("member_pw"));

	//처리 
	MemberDAO mdao =new MemberDAO();
	MemberDTO user =mdao.login(mdto);
			super.service(req, resp);
			
			//출력
			if(user==null) {//로그인 실패
				resp.sendRedirect("login.jsp?error");//로그인 페이지로
				}
			else {//로그인 성공
				mdao.updateLoginTime(user.getMember_id());
				req.getSession().setAttribute("mdto", user);
						resp.sendRedirect(req.getContextPath());
			}
		}
catch(Exception e) {
	e.printStackTrace();
	resp.sendError(500);
}
		}
	}