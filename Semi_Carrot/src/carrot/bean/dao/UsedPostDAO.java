
package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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

	// 시퀀스 생성 메소드
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

	// 글 등록 메소드
	public void write(UsedPostDTO updto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO used_post " + "( " + "post_no, " + "post_title, " + "post_content, " + "post_price, "
				+ "post_date, " + "post_view, " + "post_like, " + "used_cate_num, " + "member_no, " + "addr_no, "
				+ "post_state " + ") " + "VALUES(?,?,?,?,sysdate,0,0,?,?,?,'판매중')";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, updto.getPost_no());
		ps.setString(2, updto.getPost_title());
		ps.setString(3, updto.getPost_content());
		ps.setLong(4, updto.getPost_price());
		ps.setLong(5, updto.getUsed_cate_num());
		ps.setLong(6, updto.getMember_no());
		ps.setLong(7, updto.getAddr_no());
		ps.execute();

		con.close();

	}

	// 글 목록 메소드
	public List<UsedPostDTO> getList2() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM used_post ORDER BY post_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		List<UsedPostDTO> list = new ArrayList<>();
		while (rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);
			list.add(updto);
		}
		con.close();
		return list;
	}

	// 주소 포함 전체 목록 메소드
	public List<DetailListDTO> getList() throws Exception {
		Connection con = getConnection();
		// String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		String sql = "SELECT a.*, b.addr_state, b.addr_city, b.addr_base " + "FROM used_post a "
				+ "INNER JOIN address b " + "ON a.addr_no = b.addr_no " + "ORDER BY post_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		List<DetailListDTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailListDTO dldto = new DetailListDTO(rs);

			list.add(dldto);
		}

		con.close();
		return list;

	}

	// 단일조회
	public UsedPostDTO get(long post_no) throws Exception {
		Connection con = getConnection();

		String sql = "Select*from used_post where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, post_no);
		ResultSet rs = ps.executeQuery();

		UsedPostDTO updto = rs.next() ? new UsedPostDTO(rs) : null;

		con.close();

		return updto;
	}

	// 조회수 증가
	public void plusViewCount(long post_no, long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "update used_post set post_view = post_view+1 where post_no=? and member_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, post_no);
		ps.setLong(2, member_no);
		ps.execute();

		con.close();
	}

	// 회원 번호로 게시물 조회
	public List<UsedPostDTO> getMemberUsedPost(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM USED_POST WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		List<UsedPostDTO> list = new ArrayList<UsedPostDTO>();

		while (rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);

			list.add(updto);
		}

		con.close();

		return list;
	}
	
	// 메인 페이지 최신 중고 게시물 조회 1
	public List<UsedPostDTO> newUsedPost() throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT * FROM (SELECT ROWNUM RN, T.* FROM (SELECT A.* FROM USED_POST A LEFT OUTER JOIN ADDRESS B ON A.ADDR_NO = B.ADDR_NO ORDER BY A.POST_DATE DESC) T ) WHERE RN BETWEEN 1 AND 10";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		
		List<UsedPostDTO> list = new ArrayList<UsedPostDTO>();
		
		while(rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);
			
			list.add(updto);
		}
		
		con.close();
		
		return list;
	}

	// 메인 페이지 최신 중고 게시물 조회 2 (로그인일 경우)
	public List<UsedPostDTO> newUsedPost(long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM (SELECT ROWNUM RN, T.* FROM (SELECT A.* FROM USED_POST A LEFT OUTER JOIN ADDRESS B ON A.ADDR_NO = B.ADDR_NO WHERE A.ADDR_NO = ? ORDER BY A.POST_DATE DESC) T ) WHERE RN BETWEEN 1 AND 10";

		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setLong(1, member_addr_no);

		ResultSet rs = ps.executeQuery();

		List<UsedPostDTO> list = new ArrayList<UsedPostDTO>();

		while (rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);
			
			list.add(updto);
		}
		
		con.close();
		
		return list;
	}
	
	// 회원 거주 지역 게시글 조회 
	public List<UsedPostDTO> memberLocalUsedPost(long member_addr_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT * FROM USED_POST WHERE ADDR_NO = ? ORDER BY POST_DATE DESC";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setLong(1, member_addr_no);
		
		ResultSet rs = ps.executeQuery();
		
		List<UsedPostDTO> list = new ArrayList<UsedPostDTO>();
		
		while(rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);
			
			list.add(updto);
		}
		
		con.close();
		
		return list;
		
	}
     
	   //게시글 수정
	   public void edit(UsedPostDTO updto) throws Exception{
		   Connection con = getConnection();
		   
		   String sql="Update used_post SET post_title=?, used_cate_num=?,post_price=?,post_content=? where post_no=?";
		   PreparedStatement ps=con.prepareStatement(sql);
		   ps.setString(1, updto.getPost_title());
		   ps.setLong(2, updto.getUsed_cate_num());
		   ps.setLong(3, updto.getPost_price());
		   ps.setString(4, updto.getPost_content());
		   ps.setLong(5, updto.getPost_no());
		   
		   ps.execute();
		   
		   con.close();		   
	   }
	   
	   //게시글 삭제
	   public void delete(long post_no)throws Exception{
		   Connection con = getConnection();
		   
		   String sql="Delete used_post where post_no=?";
		   PreparedStatement ps = con.prepareStatement(sql);
		   ps.setLong(1, post_no);
		   ps.execute();
		   
		   con.close();	   
	   }

}
