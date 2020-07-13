package carrot.servlet.member;

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
public class ChangeInfoServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");

			// 로그인 회원 정보 가지고 오기
			MemberDTO memberinfo = (MemberDTO) req.getSession().getAttribute("memberinfo");
			System.out.println("null = " + req.getParameter("check_pw"));
			System.out.println(memberinfo.getMember_id() + " = 로그인 회원 아이디");
			System.out.println(memberinfo.getMember_pw() + " = 로그인 회원 비번");

			String memberinfo_pw = memberinfo.getMember_pw();

			String member_pw = req.getParameter("member_pw");
			String check_pw = req.getParameter("check_pw");
			String member_nick = req.getParameter("member_nick");
			String member_phone = req.getParameter("member_phone");
			String addr_state = req.getParameter("addr_state");
			String addr_city = req.getParameter("addr_city");
			String addr_base = req.getParameter("addr_base");

			// 세션 비밀번호와 입력한 비밀번호 비교
			if (member_pw.equals(memberinfo_pw)) {

				// Address Constructor
				AddrDTO adto = new AddrDTO();
				AddrDAO adao = new AddrDAO();

				adto.setAddr_state(addr_state);
				adto.setAddr_city(addr_city);
				adto.setAddr_base(addr_base);

				// Address Method
				Long addr_no = adao.findAddrNo(adto);
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

				mdto.setMember_nick(member_nick);
				mdto.setMember_addr_no(member_addr_no);
				mdto.setMember_phone(member_phone);
				mdto.setMember_no(member_no);

				// 현재 비밀번호와 새로운 비밀번호 비교 > 다른 경우 !!비밀번호 수정!!
				if (!check_pw.isEmpty()) {

					// 현재 비밀번호와 새로운 비밀번호가 같은지 비교
					// 다르면 성공 / 같으면 실패
					if (!member_pw.equals(check_pw)) {

						mdto.setMember_pw(check_pw);

						mdao.changeInfoWithPw(mdto);

						// 정보 수정 성공 후 마이페이지로 이동
						resp.sendRedirect("info.jsp?member_no=" + member_no);

					} else if (member_pw.equals(check_pw)) {
						
						// 바꾸려는 비밀번호와 현재 비밀번호가 같으니 다시 입력
						resp.sendRedirect("change_info.jsp?error_no=1&member_no=" + memberinfo.getMember_no());
					}

				} else if (check_pw.isEmpty()) {
					
					// 변경할 비밀번호가 없는 경우
					mdao.changeInfo(mdto);

					// 정보 수정 성공 후 마이페이지로 이동
					resp.sendRedirect("info.jsp?member_no=" + member_no);

				}

				// 세션 정보 변경
				req.getSession().removeAttribute("memberinfo");
				req.getSession().setAttribute("memberinfo", mdto);
				MemberDTO session = (MemberDTO) req.getSession().getAttribute("memberinfo");
				
				System.out.println("이메일 : " + session.getMember_id());

			} else {
				// 현재 비밀번호가 세션 비밀번호와 다를 시
				resp.sendRedirect("change_info.jsp?error_no=2&member_no=" + memberinfo.getMember_no());
			}

		} catch (Exception e) {

			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
