package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/board/delete_reply.do")
public class DeleteReplyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String reply_table_name = req.getParameter("reply_table_name");
			String post_path = req.getParameter("post_path");
			long reply_no = Long.parseLong(req.getParameter("reply_no"));
			System.out.println(post_path);
			System.out.println(reply_table_name);
			System.out.println(reply_no);

			ReplyDAO rdao = new ReplyDAO();

			rdao.deleteReply(reply_table_name, reply_no);

			resp.sendRedirect(post_path);

		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
