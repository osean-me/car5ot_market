package carrot.servlet.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.ProfileImgDAO;
import carrot.bean.dto.MemberDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/delete_profile.do")
public class ProfileImgDeleteServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			ProfileImgDAO pidao = new ProfileImgDAO();
			
			// 회원 번호 받아오기
			MemberDTO mdto = (MemberDTO) req.getAttribute("memberinfo");
			long member_no = mdto.getMember_no();
			
			// 해당 회원의 프로필 번호를 받아온다.
			long member_img_no = Long.parseLong(req.getParameter("member_img_no"));
			
			// 파일 이름 받아오기
			String member_img_name = pidao.getImgName(member_img_no);
			
			// 파일 삭제
			File profile = new File("D:/semi_carrot/upload/member_profile/" + member_img_name);
			profile.delete();
			
			// DB 삭제
			pidao.deleteProfileImg(member_no);
			
			resp.sendRedirect(req.getContextPath() + "/member/info.jsp?no=" + member_no);
			
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
