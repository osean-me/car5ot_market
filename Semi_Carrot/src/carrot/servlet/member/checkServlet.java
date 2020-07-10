package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.MemberDTO;


@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/check.do")
public class checkServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			String go = req.getParameter("go");

			String member_pw = req.getParameter("member_pw");

			MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
			String member_id = mdto.getMember_id();

			MemberDAO mdao = new MemberDAO();
			MemberDTO member = new MemberDTO();
			member.setMember_id(member_id);
			member.setMember_pw(member_pw);
			MemberDTO result = mdao.login(member);

			if (result == null) {// (로그인 실패)
				resp.sendRedirect("check.jsp?error&go=" + go);
			} else {
				resp.sendRedirect(go);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
