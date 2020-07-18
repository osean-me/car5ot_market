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

import carrot.bean.dao.PromotionPostDAO;
import carrot.bean.dao.PromotionPostImgDAO;
import carrot.bean.dao.UsedPostDAO;
import carrot.bean.dao.UsedPostImgDAO;
import carrot.bean.dto.PromotionPostDTO;
import carrot.bean.dto.PromotionPostImgDTO;
import carrot.bean.dto.UsedPostImgDTO;

@WebServlet(urlPatterns = "/board/promopostedit.do")
public class PromotionPostEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			PromotionPostDTO ppdto = new PromotionPostDTO();
			ppdto.setPost_no(Long.parseLong(req.getParameter("post_no")));
			ppdto.setPost_title(req.getParameter("post_title"));
			ppdto.setPromotion_cate_num(Long.parseLong(req.getParameter("promotion_cate_num")));
			ppdto.setPost_content(req.getParameter("post_content"));
			ppdto.setBoard_no(Long.parseLong(req.getParameter("board_no")));
			
			PromotionPostDAO ppdao = new PromotionPostDAO();
			ppdao.edit(ppdto);
			
			
		
			
			//기존 이미지 삭제
			long post_no = Long.parseLong(req.getParameter("post_no"));	
			UsedPostImgDAO upidao = new UsedPostImgDAO();	
			UsedPostImgDTO upidto = upidao.getMember(post_no);

			// 파일 삭제
			File post = new File("D:/upload/board/" + upidto.getPost_img_no());
			post.delete();
			// DB 삭제
			upidao.deleteUsedPostImg(post_no);
			
			///이미지 새로 등록///
			String charset = "UTF-8";
			int limit = 10 * 1024 * 1024;
			File baseDir = new File("D:/upload/board");
			baseDir.mkdirs();
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setDefaultCharset(charset);
			factory.setSizeThreshold(limit);
			factory.setRepository(baseDir);
			
			ServletFileUpload utility = new ServletFileUpload(factory);
			
			Map<String , List<FileItem>> map = utility.parseParameterMap(req);
			// 파일 정보를 불러와서 저장 (하드디스크 + 데이터베이스)
			List<FileItem> fileList = map.get("promotion_post_img");
			PromotionPostImgDAO bfdao = new PromotionPostImgDAO();
						
				for(FileItem item : fileList) {
							
					if(item.getSize() > 0) { //파일이 있는 경우
						PromotionPostImgDTO pidto = new PromotionPostImgDTO();

						int post_img_no = bfdao.getSequence(); // 이미지 번호 부여 
								
						pidto.setPost_img_no(post_img_no); // 이미지 번호 
						pidto.setPost_img_name(item.getName()); // 이미지이름
						pidto.setPost_img_size(item.getSize()); //이미지 사이즈
						pidto.setPost_img_type(item.getContentType()); //이미지 유형
						pidto.setPost_no(post_no); // 게시글번호 

						bfdao.save(pidto); // 저장
								
						//하드디스크에 저장
						File target = new File(baseDir, String.valueOf(post_img_no));
						item.write(target);
							}
						}

			resp.sendRedirect("promotion_post_content.jsp?board_no="+ppdto.getBoard_no()+"&promotion_cate_num="+ppdto.getPromotion_cate_num()+"&post_no="+ppdto.getPost_no());
		}
		
		
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
