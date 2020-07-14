package carrot.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import carrot.bean.dao.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/test.do")
public class test extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			ReplyDAO rdao = new ReplyDAO();

			long seq_no = rdao.getSequence("test_seq");
			
			System.out.println("테스트 시퀀스 번호 : " + seq_no);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
