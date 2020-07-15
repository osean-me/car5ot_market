package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet (urlPatterns = "/board/edit_reply.do")
public class EditReplyServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
		String reply_table_name = req.getParameter("reply_table_name");
		String post_path = req.getParameter("post_path");
		long reply_no = Long.parseLong(req.getParameter("reply_no"));
		String reply_content = req.getParameter("reply_content");
		
		ReplyDAO rdao = new ReplyDAO();
		
		rdao.editReply(reply_table_name, reply_no, reply_content);
		
		resp.sendRedirect(post_path);
		
	} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}

}
