package carrot.servlet.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dto.MemberDTO;

@WebServlet(urlPatterns = "/member/gone.do")
public class GoneServlet extends HttpServlet {
@Override
protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
	try {
		MemberDTO mdto = (MemberDTO) arg0.getSession().getAttribute("memberinfo");
		
		arg1.sendRedirect("gone.jsp");
	}
	catch(Exception e) {
		e.printStackTrace();
		arg1.sendError(500);
	}
}
}
