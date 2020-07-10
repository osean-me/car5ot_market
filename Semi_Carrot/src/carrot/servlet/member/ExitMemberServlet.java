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
@WebServlet(urlPatterns = "/members/gone.do")
public class ExitMemberServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
			MemberDAO mdao = new MemberDAO();

			int result = mdao.exitMember(mdto.getMember_no());

			if (result == 1) {
				resp.sendRedirect(req.getContextPath());
			} else {
				resp.sendRedirect(req.getContextPath() + "?failed");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}