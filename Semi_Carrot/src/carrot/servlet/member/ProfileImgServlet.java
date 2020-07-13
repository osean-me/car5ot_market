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

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/reg_profile_img.do")
public class ProfileImgServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0.form 의 multipart/form-data 방식으로 전송되는 이미지 파일을 해석하고 저장하는 과정

			// 1. 해석을 위한 도구 생성 옵션 설정
			String charset = "UTF-8"; // 인코딩 방식 > UTF-8
			int limit = 10 * 1024 * 1024; // 파일 최대 용량
			File baseDir = new File("D:/semi_carrot/upload/member_profile");
			baseDir.mkdirs();

			// 2. 도구 생성을 위한 Factory 객체 생성
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setDefaultCharset(charset); // 인코딩 타입
			factory.setSizeThreshold(limit); // 저장 최대 크기
			factory.setRepository(baseDir); // 저장 위치

			// 3. 실제 사용할 도구 생성
			ServletFileUpload utility = new ServletFileUpload(factory);

			// 4. 전송된 데이터들을 불러와서 저장
			Map<String, List<FileItem>> map = utility.parseParameterMap(req);

			// 5. 해석한 데이터에서 필요한 정보들을 추출
			long member_no = Long.parseLong(map.get("member_no").get(0).getString());

			// 6. 파일 정보를 불러와서 저장 (하드 디스트 + 데이터 베이스)
			List<FileItem> profile = map.get("member_profile");
			ProfileImgDAO pidao = new ProfileImgDAO();

			for (FileItem item : profile) {
				if (item.getSize() > 0) {

					// 데이터 베이스에 저장
					// 프로필 이미지 고유번호는 데이터 베이스 등록 메소드 안에서 호출
					ProfileImgDTO pidto = new ProfileImgDTO();

					pidto.setMember_no(member_no);
					pidto.setMember_img_name(item.getName());
					pidto.setMember_img_type(item.getContentType());
					pidto.setMember_img_size(item.getSize());

					long member_img_no = pidao.profileSave(pidto);

					// 하드 디스크에 저장
					File target = new File(baseDir, String.valueOf(member_img_no));
					item.write(target);
				}
			}

			resp.sendRedirect(req.getContextPath() + "/member/info.jsp?no=" + member_no);

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
