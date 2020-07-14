package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.ReplyDAO;
import carrot.bean.dto.ReplyDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/board/write_reply.do")
public class WriteReplyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		
		try {

			// Parameter 받기
			// replyt_no 는 댓글 작성 메소드 내에서 호출
			long member_no = Long.parseLong(req.getParameter("no"));
			long post_no = Long.parseLong(req.getParameter("post_no"));
			String reply_content = req.getParameter("reply_content");

			// 각 게시판 별 테이블 이름과, 시퀀스 테이블 가져오기
			// 1. 중고거래 : USED_POST_REPLY / USED_POST_REPLY_SEQ
			// 2. 홍보거래 : PROMOTION_POST_REPLY / PROMOTION_POST_REPLY_SEQ
			// 3. 우리동네 : COMMUNITY_POST_REPLY / COMMUNITY_POST_REPLY_SEQ
			String reply_table_name = req.getParameter("reply_table_name");
			String reply_seq_name = req.getParameter("reply_seq_name");
			
			// 해당 게시판 jsp 주소 받기
			String post_path = req.getParameter("post_path");

			// 댓글 작성을 위한 DTO / DAO 호출
			ReplyDAO rdao = new ReplyDAO();
			ReplyDTO rdto = new ReplyDTO();

			rdto.setMember_no(member_no);
			rdto.setPost_no(post_no);
			rdto.setReply_content(reply_content);

			if (req.getParameter("reply_no") != null) {
				rdto.setSuper_no(Long.parseLong(req.getParameter("reply_no")));
			}
			
			// 댓글 등록 메소드
			rdao.writeReply(rdto, reply_table_name, reply_seq_name);
			
			// 댓글 등록 완료되면 해당 게시물로 이동
			resp.sendRedirect(req.getContentType() + "/board/" + post_path + ".jsp?post_no=" + post_no);

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
