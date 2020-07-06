package carrot.servlet.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.MemberDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/user/login.do")
public class loginServlert extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");

			String member_id = req.getParameter("member_id");
			String member_pw = req.getParameter("member_pw");

			MemberDTO mdto = new MemberDTO();
			MemberDAO mdao = new MemberDAO();
			mdto.setMember_id(member_id);
			mdto.setMember_pw(member_pw);

			// 1. 로그인 기록 갱신으로 로그인 여부 확인
			int update = mdao.updateLoginTime(member_id, member_pw);

			/*
			 * update 값이 '1' 일 경우 : 로그인 성공 '0' 일 경우 : 로그인 실패
			 */
			if (update == 1) {

				MemberDTO memberinfo = mdao.login(mdto);

				req.getSession().setAttribute("memberinfo", memberinfo);

				resp.sendRedirect(req.getContextPath());
				
				System.out.println("member_id = " + memberinfo.getMember_id());
				System.out.println("session =" + req.getSession().getAttribute("memberinfo"));
			} else {
				resp.sendRedirect(req.getContextPath() + "/user/login.jsp?failed");
			}

		} catch (

		Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}