package carrot.servlet.board;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;

import carrot.bean.dao.UsedPostImgDAO;
import carrot.bean.dto.UsedPostImgDTO;


@SuppressWarnings("serial")
@WebServlet(urlPatterns="/board/showImg.do")
public class UsedThumbnailServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//post_img_no를 블러온다 
			long post_img_no = Long.parseLong(req.getParameter("post_img_no"));
			
			//데이터베이스에서 post_img_no 에 해당하는 파일 정보를 불러온다.
			UsedPostImgDAO upidao = new UsedPostImgDAO();
			UsedPostImgDTO upidto = upidao.get(post_img_no);
			
			if(upidto == null) {
				resp.sendError(404);
				return;
			}
			
			resp.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
			resp.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(upidto.getPost_img_name(), "UTF-8")+"\"");
			resp.setHeader("Content-Length", String.valueOf(upidto.getPost_img_size()));
			
			//실제 데이터를 불러와서 사용자에게 전송
			File target = new File("D:/semi_carrot/upload/board_used_post", String.valueOf(upidto.getPost_img_no()));

			byte[] data = FileUtils.readFileToByteArray(target);
			resp.getOutputStream().write(data);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
