package carrot.servlet.board;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.UsedPostDAO;
import carrot.bean.dao.UsedPostImgDAO;
import carrot.bean.dto.UsedPostDTO;
import carrot.bean.dto.UsedPostImgDTO;
import carrot.constant.FilePath;

@WebServlet(urlPatterns = "/board/usedpostdelete.do")
public class UsedPostDeleteServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			long post_no = Long.parseLong(req.getParameter("post_no"));
						
			UsedPostImgDAO upidao = new UsedPostImgDAO();
			
			UsedPostImgDTO upidto = upidao.getMember(post_no);
			
			UsedPostDAO updao = new UsedPostDAO();
			
			// 파일 삭제
			File post = new File(FilePath.postPath + upidto.getPost_img_no());
			post.delete();

			// DB 삭제
			upidao.deleteUsedPostImg(post_no);
			// 게시글 삭제
			updao.delete(post_no);
			resp.sendRedirect("used_all_post_list.jsp");
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}	
	}
}
