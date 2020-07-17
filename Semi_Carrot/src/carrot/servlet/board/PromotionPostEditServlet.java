package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.PromotionPostDAO;
import carrot.bean.dto.PromotionPostDTO;

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
			
			resp.sendRedirect("promotion_post_content.jsp?board_no="+ppdto.getBoard_no()+"&promotion_cate_num="+ppdto.getPromotion_cate_num()+"&post_no="+ppdto.getPost_no());
		}
		
		
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
