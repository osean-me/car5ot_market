package carrot.servlet.member;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import carrot.bean.dao.ProfileImgDAO;
import carrot.bean.dto.ProfileImgDTO;
import carrot.constant.FilePath;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/edit_profile.do")
public class ProfileImgEditServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		try {

			// 1. 새로 등록된 사진 도구 준비하기
			String charset = "UTF-8";
			int limit = 10 * 1024 * 1024;
			File baseDir = new File(FilePath.profilePath);
			baseDir.mkdirs();

			// 2. 공장 생성
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setDefaultCharset(charset);
			factory.setRepository(baseDir);
			factory.setSizeThreshold(limit);
			
			// 3. 실제 사용할 도구 생성
			ServletFileUpload utility = new ServletFileUpload(factory);
			
			// 4. 전송된 데이터들을불러와서 저장
			Map<String, List<FileItem>> map = utility.parseParameterMap(req);
			
			// 5. 해석한 데이터에서 필요한 정보들을 추출
			long member_no = Long.parseLong(map.get("member_no").get(0).getString()); // 회원 번호
			long before_img_no = Long.parseLong(map.get("member_img_no").get(0).getString()); // 회원 프로필 이미지 번호
				
			System.out.println("회원 번호 : " + member_no);
			System.out.println("회원 이미지 번호 : " + before_img_no);
			
			// 6. 기존 파일 삭제
			File profile_delete = new File(FilePath.profilePath + before_img_no);
			profile_delete.delete();

			// 7. DB 삭제
			ProfileImgDAO pidao = new ProfileImgDAO();
			pidao.deleteProfileImg(member_no);
			
			// 8. 파일 정보를 불러와서 저장 (하드 디스크 + 데이터 베이스)
			List<FileItem> profile = map.get("member_profile");
			
			for(FileItem item : profile) {
				ProfileImgDTO pidto = new ProfileImgDTO();
				
				pidto.setMember_no(member_no);
				pidto.setMember_img_name(item.getName());
				pidto.setMember_img_type(item.getContentType());
				pidto.setMember_img_size(item.getSize());
				
				// 8-1. DB에 저장 후 해당 이미지 번호를 반환
				long member_img_no = pidao.profileSave(pidto);
				
				// 8-2. 하드 디스크에 저장
				File target = new File(baseDir, String.valueOf(member_img_no));
				item.write(target);
			}

			resp.getWriter().println("<script>");
			resp.getWriter().println("window.opener.parent.location.reload('" + req.getContextPath() + "/member/info.jsp?no=" + member_no + "')");
			resp.getWriter().println("window.close();");
			resp.getWriter().println("</script>");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
