package carrot.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;

@WebServlet(urlPatterns = "/admin/drop.do")

@SuppressWarnings("serial")
public class AdminDropServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			String member_id=req.getParameter("member_id");
					
			MemberDAO mdao=new MemberDAO();
			mdao.exitMember(member_id);
					
			resp.sendRedirect("admin_list.jsp");
		}
		
		catch (Exception e) {
                e.printStackTrace();
                resp.sendError(500);
		}
		
		
		
	}
	

}
