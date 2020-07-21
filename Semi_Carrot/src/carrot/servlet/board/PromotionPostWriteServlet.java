package carrot.servlet.board;

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

import carrot.bean.dao.MemberDAO;
import carrot.bean.dao.PromotionPostDAO;
import carrot.bean.dao.PromotionPostImgDAO;
import carrot.bean.dto.MemberDTO;
import carrot.bean.dto.PromotionPostDTO;
import carrot.bean.dto.PromotionPostImgDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/board/promotion_post_write.do")
public class PromotionPostWriteServlet extends HttpServlet {
//		목표: 게시글 등록 후 동네홍보 상세페이지로 이동 
	/*
	 * 준비 : 글번호(post_no), 중고거래 카테고리 번호(used_cate_num), 제목(post_title),
	 * 작성자(member_no), 내용(post_content), 가격(post_price), 상태(post_state)
	 */
	// 파라미터로 받을 값 : 카테고리 번호, 제목, 내용, 가격, 상태
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setCharacterEncoding("UTF-8");

		try {
			String charset = "UTF-8";
			int limit = 10 * 1024 * 1024;

			File baseDir = new File("D:/upload/board");

			baseDir.mkdirs();

			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setDefaultCharset(charset);
			factory.setSizeThreshold(limit);
			factory.setRepository(baseDir);

			ServletFileUpload utility = new ServletFileUpload(factory);

			Map<String, List<FileItem>> map = utility.parseParameterMap(req);

			FileItem checkImg = map.get("promotion_post_img").get(0);
			boolean check = !map.get("promotion_cate_num").get(0).getString().isEmpty()
					&& !map.get("post_title").get(0).getString().isEmpty()
					&& !map.get("post_content").get(0).getString().isEmpty()
					&& !map.get("post_phone").get(0).getString().isEmpty()
					&& !map.get("post_price").get(0).getString().isEmpty();

			if (checkImg.getSize() > 0 && check) {
				// 이미지가 있을 경우
				// 회원 정보 가져오기
				MemberDAO mdao = new MemberDAO();
				MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
				long member_no = mdto.getMember_no();
				MemberDTO loginmember = mdao.get(member_no);

				// 게시글 정보 가져오기
				PromotionPostDTO ppdto = new PromotionPostDTO();
				ppdto.setPromotion_cate_num(Long.parseLong(map.get("promotion_cate_num").get(0).getString())); // 카테고리번호
				ppdto.setPost_title(map.get("post_title").get(0).getString()); // 제목
				ppdto.setPost_content(map.get("post_content").get(0).getString()); // 내용
				ppdto.setPost_phone(map.get("post_phone").get(0).getString()); // 전화번호
				ppdto.setPost_price(Long.parseLong(map.get("post_price").get(0).getString())); // 가격
				ppdto.setBoard_no(Long.parseLong(map.get("board_no").get(0).getString())); // 게시판 번호
				ppdto.setMember_no(member_no);
				ppdto.setAddr_no(loginmember.getMember_addr_no());

				// 게시글 함수 실행
				PromotionPostDAO ppdao = new PromotionPostDAO();
				int post_no = ppdao.getSequence(); // 번호 먼저 추출
				ppdto.setPost_no(post_no); // 들어갈 번호 설정 후

				ppdao.write(ppdto); // 등록

				// 파일 정보를 불러와서 저장 (하드디스크 + 데이터베이스)
				List<FileItem> fileList = map.get("promotion_post_img");
				PromotionPostImgDAO bfdao = new PromotionPostImgDAO();

				for (FileItem item : fileList) {

					if (item.getSize() > 0) { // 파일이 있는 경우
						PromotionPostImgDTO pidto = new PromotionPostImgDTO();

						int post_img_no = bfdao.getSequence(); // 이미지 번호 부여

						pidto.setPost_img_no(post_img_no); // 이미지 번호
						pidto.setPost_img_name(item.getName()); // 이미지이름
						pidto.setPost_img_size(item.getSize()); // 이미지 사이즈
						pidto.setPost_img_type(item.getContentType()); // 이미지 유형
						pidto.setPost_no(post_no); // 게시글번호

						bfdao.save(pidto); // 저장

						// 하드디스크에 저장
						File target = new File(baseDir, String.valueOf(post_img_no));
						item.write(target);
					}
				}
				resp.sendRedirect("promotion_post_content.jsp?board_no=" + ppdto.getBoard_no() + "&promotion_cate_num="
						+ ppdto.getPromotion_cate_num() + "&post_no=" + ppdto.getPost_no());
			} else {
				if (!check) {
					resp.sendRedirect(req.getContextPath() + "/board/promotion_write.jsp?content_error");
				} else {
					resp.sendRedirect(req.getContextPath() + "/board/promotion_write.jsp?img_error");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
