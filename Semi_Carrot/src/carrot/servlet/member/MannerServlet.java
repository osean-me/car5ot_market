package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MannerDAO;
import carrot.bean.dto.MannerDTO;
import carrot.bean.dto.MannerListDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/manner.do")
public class MannerServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 도구 불러오기
			MannerDAO mndao = new MannerDAO();

			// this 회원 / push 회원 정보 받아오기
			long this_member_no = Long.parseLong(req.getParameter("this_member_no"));
			long push_member_no = Long.parseLong(req.getParameter("push_member_no"));
			String path = req.getParameter("path");

			// this 회원의 매너지수 가져오기
			MannerDTO this_member = mndao.getMannerCount(this_member_no);
			long this_member_count = this_member.getManner_count();

			// push 한 회원이 this 회원을 좋아요 한 경력이 있는지
			MannerListDTO mnldto = mndao.getPushMember(this_member_no, push_member_no);

			// 좋아요 / 싫어요 어떤 것을 눌렀는지 검열
			if (req.getParameter("good") != null) {
				// 좋아요의 경우
				if (mnldto == null) {
					// push 회원의 좋아요 기록이 없을 경우
					// push 회원의 좋아요 기록 갱신
					mndao.updatePush(this_member_no, push_member_no);
					// this 회원의 매너 지수 +10
					this_member_count += 10;

					// 해당 정보로 매너 지수 업데이트
					mndao.updateManner(this_member_no, this_member_count);
					resp.sendRedirect(path);
				} else {
					// push 회원의 좋아요 기록이 있을 경우 되돌아가기
					resp.sendRedirect(path);
				}

			} else if (req.getParameter("bad") != null) {
				// 싫어요의 경우
				if (mnldto != null) {
					// push 회원의 좋아요 기록이 있을 경우
					// push 회원의 좋아요 기록 삭제
					mndao.deletePush(this_member_no, push_member_no);
					// this 회원의 매너 지수 -10
					this_member_count -= 10;

					// 해당 정보로 매너 지수 업데이트
					mndao.updateManner(this_member_no, this_member_count);
					resp.sendRedirect(path);
				} else {
					// push 회원의 좋아요 기록이 없을 경우
					resp.sendRedirect(path);
				}
			} else {
				resp.sendRedirect(req.getContextPath());
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
