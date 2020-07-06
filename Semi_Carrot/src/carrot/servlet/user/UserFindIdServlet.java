package carrot.servlet.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.MemberDTO;

@WebServlet(urlPatterns="/user/find_id.do")
public class UserFindIdServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//입력 : member_nick , member_phone , member_birth  -----> MemberDto
			req.setCharacterEncoding("UTF-8");
			MemberDTO mdto = new MemberDTO();
			mdto.setMember_nick(req.getParameter("member_nick"));
			mdto.setMember_phone(req.getParameter("member_phone"));
			
			//처리
			MemberDAO mdao = new MemberDAO();
			String member_id = mdao.findId(mdto);
			
			//출력
			if(member_id != null) {
				
				req.getSession().setAttribute("member_id", member_id);
				resp.sendRedirect("find_id_result.jsp");
			}
			else {//결과가 없으면
				resp.sendRedirect("find_id.jsp?error");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}





