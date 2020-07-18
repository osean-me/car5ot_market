package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.MannerDAO;
import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.MemberDTO;



@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/gone.do")
public class ExitMemberServlet extends HttpServlet {
	/**
	 *
	 */
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 파라미터로 받아온 데이터 변수
			long member_no = Long.parseLong(req.getParameter("member_no"));
			String member_pw = req.getParameter("member_pw");
			String member_phone = req.getParameter("member_phone");
			
			MemberDAO mdao = new MemberDAO();
			MemberDTO check = mdao.get(member_no);
			
			if(!check.getMember_pw().equals(member_pw) || !check.getMember_phone().equals(member_phone)) {
				
				// 비밀번호나 핸드폰 번호가 다를 경우 다시 탈퇴 페이지로 보내라.
				resp.sendRedirect(req.getContextPath() + "/member/check_exit.jsp?no=" + member_no + "&failed");
				return;
			}
			
			// 탈퇴 전 세션 삭제
			req.getSession().removeAttribute("memberinfo");
			
			// 매너지수 관련 테이블에서 회원의 모든 데이터 삭제
			MannerDAO mndao = new MannerDAO();
			mndao.dropManner(member_no);
			
			// 탈퇴
			mdao.exit(member_no);
			
			resp.sendRedirect(req.getContextPath());
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}