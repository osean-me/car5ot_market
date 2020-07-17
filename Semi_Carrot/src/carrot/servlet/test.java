//package carrot.servlet;
//
//import java.io.File;
//import java.io.IOException;
//import java.util.List;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import carrot.bean.dao.ProfileImgDAO;
//import carrot.bean.dao.ReplyDAO;
//import carrot.bean.dao.UsedPostDAO;
//import carrot.bean.dto.MemberDTO;
//import carrot.bean.dto.RecomDTO;
//
//@SuppressWarnings("serial")
//@WebServlet(urlPatterns = "/test.do")
//public class test extends HttpServlet {
//
//	@Override
//	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		try {
//			long used_cate_num = 1;
//			long addr_no = 1;
//			
//			UsedPostDAO updao = new UsedPostDAO();
//			
//			List<RecomDTO> list = updao.getRecomPost(used_cate_num, addr_no);
//			
//			for(RecomDTO rcdto : list) {
//				System.out.println(rcdto.getPost_title());
//			}
//
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//
//	}
//
//}
