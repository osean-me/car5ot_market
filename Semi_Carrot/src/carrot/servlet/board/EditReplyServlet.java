package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/board/edit_reply.do")
public class EditReplyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			// 댓글이 속한 게시판의 댓글 테이블 이름
			String reply_table_name = req.getParameter("reply_table_name");
			// 되돌아갈 주소
			String post_path = req.getParameter("post_path");
			
			// 댓글 번호
			long reply_no = Long.parseLong(req.getParameter("reply_no"));
			// 댓글 수정 내용
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
