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
@WebServlet(urlPatterns = "/member/gone.do")
public class ExitMemberServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
			String member_id = mdto.getMember_id();

			// 처리a
			MemberDAO mdao = new MemberDAO();
			mdao.drop(member_id);

			req.getSession().removeAttribute("memberinfo");
			
			resp.sendRedirect(req.getContextPath() + "/member/gone.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
