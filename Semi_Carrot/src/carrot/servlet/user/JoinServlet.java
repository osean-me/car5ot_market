package carrot.servlet.user;

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
@WebServlet(urlPatterns = "/user/join.do")
public class JoinServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// Address Table Data
			String addr_state = req.getParameter("addr_state");
			String addr_city = req.getParameter("addr_city");
			String addr_base = req.getParameter("addr_base");

			// Address Constructor
			AddrDTO adto = new AddrDTO();
			AddrDAO adao = new AddrDAO();

			// Address Method
			Long addr_no = adao.findAddrNo(addr_base);
			if(addr_no == null) {
				addr_no = adao.getAddrNo();
				adto.setAddr_no(addr_no);
				adto.setAddr_state(addr_state);
				adto.setAddr_city(addr_city);
				adto.setAddr_base(addr_base);
				
				adao.insertAddr(adto);
			}

			// Member Table Data
			String member_id = req.getParameter("member_id");
			String member_pw = req.getParameter("member_pw");
			String member_nick = req.getParameter("member_nick");
			long member_addr_no = addr_no.longValue();
			String member_phone = req.getParameter("member_phone");
			
			// Member Constructor
			MemberDTO mdto = new MemberDTO();
			MemberDAO mdao = new MemberDAO();
			
			// Member Method
			long member_no = mdao.getMemberNo();
			
			mdto.setMember_no(member_no);
			mdto.setMember_id(member_id);;
			mdto.setMember_pw(member_pw);
			mdto.setMember_addr_no(member_addr_no);
			mdto.setMember_nick(member_nick);
			mdto.setMember_phone(member_phone);
			
			mdao.join(mdto);
			
			resp.sendRedirect("https://www.naver.com/");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
