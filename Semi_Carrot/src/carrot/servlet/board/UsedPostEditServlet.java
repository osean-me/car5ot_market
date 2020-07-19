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

import carrot.bean.dao.UsedPostDAO;
import carrot.bean.dao.UsedPostImgDAO;
import carrot.bean.dto.UsedPostDTO;
import carrot.bean.dto.UsedPostImgDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/board/usedpostedit.do")
public class UsedPostEditServlet extends HttpServlet {
   @Override
   protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

      resp.setCharacterEncoding("UTF-8");

      try {

         // 1. 수정 페이지에서 등록된 데이터 처리 도구 준비하기
         String charset = "UTF-8";
         int limit = 10 * 1024 * 1024;
         File baseDir = new File("F:/upload/board");
         baseDir.mkdirs();

         // 2. 공장 생성
         DiskFileItemFactory factory = new DiskFileItemFactory();
         factory.setDefaultCharset(charset);
         factory.setRepository(baseDir);
         factory.setSizeThreshold(limit);

         // 3. 실제 사용할 도구 생성
         ServletFileUpload utility = new ServletFileUpload(factory);

         // 4. 전송된 데이터들을 불러와서 저장
         Map<String, List<FileItem>> map = utility.parseParameterMap(req);

         // 5. 해석한 데이터에서 필요한 정보들을 추출

         // 5-1. 게시글 수정 데이터 받아오기
         long board_no = Long.parseLong(map.get("board_no").get(0).getString()); // 게시판 번호
         long used_cate_num = Long.parseLong(map.get("used_cate_num").get(0).getString()); // 카테고리 번호
         long post_no = Long.parseLong(map.get("post_no").get(0).getString()); // 게시글 번호
         String post_title = map.get("post_content").get(0).getString(); // 게시글 제목
         long post_price = Long.parseLong(map.get("post_price").get(0).getString()); // 상품 가격
         String post_content = map.get("post_content").get(0).getString();

         

         // 7. 파라미터로 받아온 파일 정보 불러와서 저장 (하드 디스크 + DB)
         List<FileItem> new_img_list = map.get("used_post_img");
         
        // System.out.println(!new_img_list.get(0).getName().isEmpty());
         
         if (!new_img_list.get(0).getName().isEmpty()) {	//추가한 이미지가 있으면
            // 5-2. 게시글 번호로 삭제할 게시글 이미지 번호 받아오기
            UsedPostImgDAO uidao = new UsedPostImgDAO();
            List<UsedPostImgDTO> old_img_no = uidao.getList(post_no);

            // 5-3. DB 삭제
            uidao.deleteUsedPostImg(post_no);

            // 5-4. 받아온 예전 이미지 파일 삭제
            for (UsedPostImgDTO uidto : old_img_no) {
               // 파일 본체 삭제
               File delete_old_img = new File("F:/upload/board/" + uidto.getPost_img_no());
               delete_old_img.delete();
            }
            for (FileItem new_img : new_img_list) {
               UsedPostImgDTO uidto = new UsedPostImgDTO();

               long new_post_img_no = uidao.getSequence();

               uidto.setPost_img_no(new_post_img_no);
               uidto.setPost_no(post_no);
               uidto.setPost_img_name(new_img.getName());
               uidto.setPost_img_type(new_img.getContentType());
               uidto.setPost_img_size(new_img.getSize());

               // 7-1. 해당 정보 DB에 저장
               uidao.save(uidto);

               // 7-2. 해당 파일 하드디스크에 저장
               File target = new File(baseDir, String.valueOf(new_post_img_no));
               new_img.write(target);
            }
         }
         
         // 6. 게시글 수정
                  UsedPostDAO updao = new UsedPostDAO();
                  UsedPostDTO updto = new UsedPostDTO();

                  updto.setBoard_no(board_no);
                  updto.setUsed_cate_num(used_cate_num);
                  updto.setPost_no(post_no);
                  updto.setPost_title(post_title);
                  updto.setPost_price(post_price);
                  updto.setPost_content(post_content);

                  updao.edit(updto);
         
         resp.sendRedirect("used_post_content.jsp?board_no=" + updto.getBoard_no() + "&used_cate_num="
               + updto.getUsed_cate_num() + "&post_no=" + updto.getPost_no());

      } catch (Exception e) {
         e.printStackTrace();
         resp.sendError(500);
      }
   }
}