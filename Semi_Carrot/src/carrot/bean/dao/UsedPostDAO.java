package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.AddrDTO;
import carrot.bean.dto.DetailListDTO;
import carrot.bean.dto.UsedPostDTO;

public class UsedPostDAO {
	private static DataSource src;

	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return src.getConnection();
	}
	
	//시퀀스 생성 메소드  
	public int getSequence() throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT post_seq.nextval FROM dual"; // 게시글 번호 
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int seq = rs.getInt(1);
		
		con.close();
		return seq;
	}
	
	//글 등록 메소드 
	public void write(UsedPostDTO updto) throws Exception {
		Connection con = getConnection();
		
		String sql = "INSERT INTO used_post "
				+ "( "
				+ "post_no, "
				+ "post_title, "
				+ "post_content, "
				+ "post_price, "
				+ "post_date, "
				+ "post_view, "
				+ "post_like, "
				+ "used_cate_num, "
				+ "member_no, "
				+ "addr_no, "
				+ "post_state "
				+ ") " 
				+"VALUES(?,?,?,?,sysdate,0,0,?,?,?,'판매중')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, updto.getPost_no());
		ps.setString(2,updto.getPost_title());
		ps.setString(3, updto.getPost_content());
		ps.setLong(4, updto.getPost_price());
		ps.setLong(5, updto.getUsed_cate_num());
		ps.setLong(6, updto.getMember_no());
		ps.setLong(7,updto.getAddr_no());
		ps.execute();
		
		con.close();
		
	}
	

	//글 목록 메소드 
	public List<UsedPostDTO> getList2() throws Exception {
		Connection con = getConnection();
		String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		List<UsedPostDTO> list = new ArrayList<>();
		while(rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);
			list.add(updto);
		}	
		con.close();
		return list;		
	}
	
	
	// 주소 포함 전체 목록 메소드 
	public List<DetailListDTO> getList() throws Exception {
		Connection con = getConnection();
		//String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		String sql = "SELECT a.*, b.addr_state, b.addr_city, b.addr_base "
							+ "FROM used_post a "
							+ "INNER JOIN address b "
							+ "ON a.addr_no = b.addr_no "
							+ "ORDER BY post_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		List<DetailListDTO> list = new ArrayList<>();
		while(rs.next()) {
			DetailListDTO dldto = new DetailListDTO(rs);
			
			list.add(dldto);
		}
		
		con.close();
		return list;
		
	}
	
	
	
	
	
	
	
	
}
