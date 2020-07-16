package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.LikeDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/post_like.do")
public class PostLikeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 회원 번호 / 게시판 번호 / 게시글 번호 받아오기
			long member_no = Long.parseLong(req.getParameter("member_no"));
			long board_no = Long.parseLong(req.getParameter("board_no"));
			long post_no = Long.parseLong(req.getParameter("post_no"));
			// path
			String path = req.getParameter("post_path");
			
			// 회원이 찜한 게시글인지 체크하기
			LikeDTO ldto = new LikeDTO();
			
			ldto.setMember_no(member_no);
			ldto.setBoard_no(board_no);
			ldto.setPost_no(post_no);
			
			MemberDAO mdao = new MemberDAO();
			Long check = mdao.searchLike(ldto);
			
			if(check == null) {
				// 찜 목록에 없으면
				mdao.insertLike(ldto);
				
				resp.sendRedirect(path + "&succ");
				
			} else {
				// 찜 목록에 있으면
				mdao.deleteLike(ldto);
				
				resp.sendRedirect(path + "&del");
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
