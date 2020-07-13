package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.UsedPostDAO;
import carrot.bean.dto.UsedPostDTO;

@WebServlet(urlPatterns = "/board/usedpostedit.do")
public class UsedPostEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			UsedPostDTO updto = new UsedPostDTO();
			updto.setPost_no(Long.parseLong(req.getParameter("post_no")));
			updto.setPost_title(req.getParameter("post_title"));
			updto.setUsed_cate_num(Long.parseLong(req.getParameter("used_cate_num")));
			updto.setPost_price(Long.parseLong(req.getParameter("post_price")));
			updto.setPost_content(req.getParameter("post_content"));
			
			UsedPostDAO updao = new UsedPostDAO();
			updao.edit(updto);
			
			resp.sendRedirect("used_post_content.jsp?post_no="+updto.getPost_no());
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
