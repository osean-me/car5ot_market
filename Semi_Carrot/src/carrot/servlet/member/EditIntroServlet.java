package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.IntroDAO;
import carrot.bean.dto.IntroDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/edit_intro.do")
public class EditIntroServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		try {
			IntroDAO idao = new IntroDAO();
			IntroDTO idto = new IntroDTO();

			long member_no = Long.parseLong(req.getParameter("member_no"));
			String intro = req.getParameter("intro");

			idto.setMember_no(member_no);
			idto.setIntro(intro);

			idao.writeIntro(idto);
			
			resp.sendRedirect(req.getContextPath() + "/member/info.jsp?no=" + member_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
