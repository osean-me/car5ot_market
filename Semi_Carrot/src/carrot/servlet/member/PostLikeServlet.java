package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.LikeDAO;
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

			// 게시글 테이블 이름
			String post_table = req.getParameter("post_table");

			// 회원이 찜한 게시글인지 체크하기
			LikeDAO ldao = new LikeDAO();
			LikeDTO ldto = new LikeDTO();

			ldto.setMember_no(member_no);
			ldto.setBoard_no(board_no);
			ldto.setPost_no(post_no);

			Long check = ldao.searchLike(ldto);

			// 게시글 좋아요 개수 불러오기
			Long post_like_count = ldao.getPostLikeCount(post_table, post_no);

			if (check == null) {
				// 찜 목록에 없으면
				// POST_LIKE 데이터 추가
				ldao.insertLike(ldto);
				// 게시글 찜 개수 + 1
				post_like_count += 1;
				// 게시글 찜 개수 갱신
				ldao.editPostLike(post_table, post_no, post_like_count);

				resp.sendRedirect(path);

			} else {
				// 찜 목록에 있으면
				// POST_LIKE 데이터 삭제
				ldao.deleteLike(ldto);
				// 게시글 찜 개수 -1
				post_like_count -= 1;
				// 게시글 찜 개수 갱신
				ldao.editPostLike(post_table, post_no, post_like_count);

				resp.sendRedirect(path);
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
