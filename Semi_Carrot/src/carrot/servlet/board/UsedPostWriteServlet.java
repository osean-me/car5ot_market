package carrot.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.UsedPostDAO;
import carrot.bean.dto.MemberDTO;
import carrot.bean.dto.UsedPostDTO;

@WebServlet(urlPatterns="/board/used_post_write.do")
public class UsedPostWriteServlet extends HttpServlet{
	// 		목표: 게시글 등록 후 중고거래 상세페이지로 이동 
	/* 	준비 : 중고거래 카테고리 번호(used_cate_num), 제목(post_title), 작성자(member_no), 
				  내용(post_content), 가격(post_price), 상태(post_state) */
	// 파라미터로 받을 값 : 카테고리 번호, 제목, 내용, 가격, 상태 
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
}
