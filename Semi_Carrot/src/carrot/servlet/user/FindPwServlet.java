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
@WebServlet(urlPatterns = "/user/find_pw.do")
public class FindPwServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 비밀번호 찾기 서블릿

			req.setCharacterEncoding("UTF-8");
			MemberDTO mdto = new MemberDTO();
			mdto.setMember_id(req.getParameter("member_id"));
			mdto.setMember_nick(req.getParameter("member_nick"));
			mdto.setMember_phone(req.getParameter("member_phone"));

			// 처리
			MemberDAO mdao = new MemberDAO();
			String member_pw;
			member_pw = mdao.findPW(mdto);

			// 출력
			if (member_pw != null) {

				req.getSession().setAttribute("member_pw", member_pw);
				resp.sendRedirect("find_pw_result.jsp");

			} else {

				resp.sendRedirect("find_id_pw.jsp?not_find=pw");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}