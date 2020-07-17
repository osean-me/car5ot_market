package carrot.servlet.board;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.PromotionPostDAO;
import carrot.bean.dao.PromotionPostImgDAO;
import carrot.bean.dto.PromotionPostImgDTO;

@WebServlet(urlPatterns = "/board/promopostdelete.do")
public class PromotionPostDeleteServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long post_no = Long.parseLong(req.getParameter("post_no"));
			
			PromotionPostImgDAO ppidao = new PromotionPostImgDAO();
			PromotionPostImgDTO ppidto = ppidao.getMember(post_no);
			PromotionPostDAO ppdao = new PromotionPostDAO();
			
			//파일삭제
			File post = new File("D:/upload/board/" + ppidto.getPost_img_no());
			post.delete();
			
			// DB 삭제
			ppidao.deletePromotionPostImg(post_no);
			// 게시글 삭제
			ppdao.delete(post_no);
			resp.sendRedirect("used_all_post_list.jsp");
			
		}
		
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
