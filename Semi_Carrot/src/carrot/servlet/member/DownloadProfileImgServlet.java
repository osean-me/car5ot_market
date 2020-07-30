package carrot.servlet.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import carrot.bean.dao.ProfileImgDAO;
import carrot.bean.dto.ProfileImgDTO;
import carrot.constant.FilePath;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/profile_img_down.do")
public class DownloadProfileImgServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 1. 해당 회원의 프로필 이미지 번호 받아오기
			long member_img_no = Long.parseLong(req.getParameter("member_img_no"));
			
			// 2. 해당 회원의 프로필 DB 얻기
			ProfileImgDAO pidao = new ProfileImgDAO();
			ProfileImgDTO pidto = pidao.getProfileImg(member_img_no);
			
			// 2-1. 만약 회원 이미지가 없다면 사용자에게 오류 송출
			if(pidto == null) {
				resp.sendError(404);
				return; // 중지
			}
			
			// 3. 다운로드를 위해 사용자에게 필요한 정보들을 알려주도록 설정 > header 설정
			resp.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=" + String.valueOf(pidto.getMember_img_name()));
			resp.setHeader("Content-Length", String.valueOf(pidto.getMember_img_size()));
			
			// 4. 실제 데이터 사용자에게 전송
			File target = new File(FilePath.profilePath,String.valueOf(pidto.getMember_img_no()));
			byte[] data = FileUtils.readFileToByteArray(target);
			
			resp.getOutputStream().write(data);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
