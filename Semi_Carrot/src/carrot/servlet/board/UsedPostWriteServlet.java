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

import carrot.bean.dao.UsedPostImgDAO;
import carrot.bean.dao.UsedPostDAO;
import carrot.bean.dto.MemberDTO;
import carrot.bean.dto.UsedPostImgDTO;
import carrot.bean.dto.UsedPostDTO;

   @WebServlet(urlPatterns="/board/used_post_write.do")
   public class UsedPostWriteServlet extends HttpServlet{
      //       목표: 게시글 등록 후 중고거래 상세페이지로 이동 
      /*    준비 : 글번호(post_no), 중고거래 카테고리 번호(used_cate_num), 제목(post_title), 작성자(member_no), 
                 내용(post_content), 가격(post_price), 상태(post_state) */
      // 파라미터로 받을 값 : 카테고리 번호, 제목, 내용, 가격, 상태 
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
            
            Map<String , List<FileItem>> map = utility.parseParameterMap(req);                  
            
            // 회원 정보 가져오기 
            MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
            long member_no = mdto.getMember_no();
            long member_addr_no = mdto.getMember_addr_no();

            //중고거래 게시글 정보 가져오기
            UsedPostDTO updto = new UsedPostDTO();
            updto.setUsed_cate_num(Long.parseLong(map.get("used_cate_num").get(0).getString())); // 카테고리번호
            updto.setPost_title(map.get("post_title").get(0).getString()); //제목
            updto.setPost_content(map.get("post_content").get(0).getString()); // 내용
            updto.setPost_price(Long.parseLong(map.get("post_price").get(0).getString())); //가격
            updto.setMember_no(member_no);
            updto.setAddr_no(member_addr_no);
            
            //중고거래 게시글 함수 실행         
            UsedPostDAO updao = new UsedPostDAO();
            int post_no = updao.getSequence(); //번호 먼저 추출
            updto.setPost_no(post_no); // 들어갈 번호 설정 후
            
            updao.write(updto); // 등록
            
            // 파일 정보를 불러와서 저장 (하드디스크 + 데이터베이스)
            List<FileItem> fileList = map.get("used_post_img");
            UsedPostImgDAO bfdao = new UsedPostImgDAO();
            
            for(FileItem item : fileList) {
               
               if(item.getSize() > 0) { //파일이 있는 경우
                  UsedPostImgDTO pidto = new UsedPostImgDTO();

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
            resp.sendRedirect("used_post_content.jsp?post_no="+updto.getPost_no()); // 일단은 리스트로 보내기  + 나중에 상세페이지 완성되면 완성 페이지로 전송 
         }
         catch(Exception e) {
            e.printStackTrace();
            resp.sendError(500);
         }
      }

   }
   
   
   
   //       목표: 게시글 등록 후 중고거래 상세페이지로 이동 
   /*    준비 : 중고거래 카테고리 번호(used_cate_num), 제목(post_title), 작성자(member_no), 
              내용(post_content), 가격(post_price), 상태(post_state) */
   // 파라미터로 받을 값 : 카테고리 번호, 제목, 내용, 가격, 상태 
   
   /*
   @Override
   
   protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
      try {
         req.setCharacterEncoding("UTF-8");
         
         MemberDTO mdto = (MemberDTO) req.getSession().getAttribute("memberinfo");
         long member_no = mdto.getMember_no();
         long member_addr_no = mdto.getMember_addr_no();
         
         UsedPostDTO updto = new UsedPostDTO();
         updto.setUsed_cate_num(Long.parseLong(req.getParameter("used_cate_num")));
         updto.setPost_title(req.getParameter("post_title"));
         updto.setPost_content(req.getParameter("post_content"));
         updto.setPost_price(Long.parseLong(req.getParameter("post_price")));
         updto.setMember_no(member_no);
         updto.setAddr_no(member_addr_no);
         
         UsedPostDAO updao = new UsedPostDAO();
         int post_no = updao.getSequence(); //번호 먼저 추출
         
         updto.setPost_no(post_no); // 들어갈 번호 설정 후
         updao.write(updto); // 등록
         
         resp.sendRedirect("post_list.jsp"); // 일단은 리스트로 보내기  + 나중에 상세페이지 완성되면 완성 페이지로 전송 
         
         
      }
      catch(Exception e) {
         e.printStackTrace();
      
      }
   }
   */
   
