package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import carrot.bean.dto.PromotionPostImgDTO;

public class PromotionPostImgDAO {
private static DataSource src;
	
	static{
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		}
		catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws SQLException {
		return src.getConnection();	
	}
	
	//시퀀스 생성 메소드 
	public int getSequence() throws SQLException {
		Connection con = getConnection();
		
		String sql = "SELECT post_img_seq.nextval FROM dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int req = rs.getInt(1);
		
		con.close();
		return req;
	}
	
	// 저장 메소드 (중고거래 게시글)
	public void save(PromotionPostImgDTO updto) throws Exception {
		Connection con = getConnection();
		
		String sql = "INSERT INTO promotion_post_img VALUES(?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, updto.getPost_img_no());
		ps.setLong(2, updto.getPost_no());
		ps.setString(3, updto.getPost_img_name());
		ps.setString(4, updto.getPost_img_type());
		ps.setLong(5, updto.getPost_img_size());
		ps.execute();
		
		con.close();
	}
	
}
