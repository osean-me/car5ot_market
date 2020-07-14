package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.UsedPostDAO;

@WebServlet(urlPatterns = "/board/usedpostdelete.do")
public class UsedPostDeleteServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long post_no = Long.parseLong(req.getParameter("post_no"));
			
			UsedPostDAO updao = new UsedPostDAO();
			updao.delete(post_no);
			
			resp.sendRedirect("post_list.jsp");
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}	
	}
}
