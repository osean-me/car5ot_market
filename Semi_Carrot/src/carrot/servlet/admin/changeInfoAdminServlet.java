package carrot.servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.AddrDAO;
import carrot.bean.dao.MemberDAO;
import carrot.bean.dto.AddrDTO;
import carrot.bean.dto.MemberDTO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/member/change_info.do")
public class changeInfoAdminServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			// 로그인 회원 정보 가지고 오기
			MemberDTO memberinfo = (MemberDTO) req.getSession().getAttribute("memberinfo");
			
			// Address Table Data
			String addr_state = req.getParameter("addr_state");
			String addr_city = req.getParameter("addr_city");
			String addr_base = req.getParameter("addr_base");
			// Address Constructor
			AddrDTO adto = new AddrDTO();
			AddrDAO adao = new AddrDAO();

			// Address Method
			Long addr_no = adao.findAddrNo(addr_base);
			if (addr_no == null) {
				addr_no = adao.getAddrNo();
				adto.setAddr_no(addr_no);
				adto.setAddr_state(addr_state);
				adto.setAddr_city(addr_city);
				adto.setAddr_base(addr_base);

				adao.insertAddr(adto);
			}

			// 위의 데이터를 기준으로 회원정보 수정 (파라미터로 데이터 받아옴)
			MemberDTO mdto = new MemberDTO();
			MemberDAO mdao = new MemberDAO();

			long member_no = memberinfo.getMember_no();
			long member_addr_no = addr_no.longValue();
			String member_nick = req.getParameter("member_nick");
			String member_phone = req.getParameter("member_phone");
			
			mdto.setMember_nick(member_nick);
			mdto.setMember_addr_no(member_addr_no);
			mdto.setMember_phone(member_phone);
			mdto.setMember_no(member_no);
			// 처리
			mdao.changeInfo(mdto);

			// 출력
			resp.sendRedirect("info.jsp");

		} catch (Exception e) {

			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
