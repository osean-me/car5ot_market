
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
import carrot.bean.dto.DetailList3DTO;
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
				+ "post_state, " + "board_no " + ") " + "VALUES(?,?,?,?,sysdate,0,0,?,?,?,'판매중',?)";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, updto.getPost_no());
		ps.setString(2, updto.getPost_title());
		ps.setString(3, updto.getPost_content());
		ps.setLong(4, updto.getPost_price());
		ps.setLong(5, updto.getUsed_cate_num());
		ps.setLong(6, updto.getMember_no());
		ps.setLong(7, updto.getAddr_no());
		ps.setLong(8, updto.getBoard_no());
		ps.execute();

		con.close();

	}

	/*
	 * //글 목록 메소드 public List<UsedPostDTO> getList2() throws Exception { Connection
	 * con = getConnection(); String sql
	 * ="SELECT * FROM used_post ORDER BY post_no DESC"; PreparedStatement ps =
	 * con.prepareStatement(sql);
	 * 
	 * ResultSet rs = ps.executeQuery(); List<UsedPostDTO> list = new ArrayList<>();
	 * while(rs.next()) { UsedPostDTO updto = new UsedPostDTO(rs); list.add(updto);
	 * } con.close(); return list; }
	 * 
	 * 
	 * // 주소 포함 전체 목록 메소드 public List<DetailListDTO> getList() throws Exception {
	 * Connection con = getConnection(); //String sql
	 * ="SELECT * FROM used_post ORDER BY post_no DESC"; String sql =
	 * "SELECT a.*, b.addr_state, b.addr_city, b.addr_base " + "FROM used_post a " +
	 * "INNER JOIN address b " + "ON a.addr_no = b.addr_no " +
	 * "ORDER BY post_no DESC"; PreparedStatement ps = con.prepareStatement(sql);
	 * 
	 * ResultSet rs = ps.executeQuery(); List<DetailListDTO> list = new
	 * ArrayList<>(); while(rs.next()) { DetailListDTO dldto = new
	 * DetailListDTO(rs);
	 * 
	 * list.add(dldto); }
	 * 
	 * con.close(); return list;
	 * 
	 * }
	 */

	// @@@@ 전체 목록 메소드 @@@@

	// (목록) 전체 목록 출력(+ 페이지 네비게이션)
	public List<DetailList3DTO> getList(int start, int finish) throws Exception {
		Connection con = getConnection();
		// String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM used_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM used_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "ORDER BY post.post_no DESC " + ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList3DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList3DTO dldto = new DetailList3DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// (검색) 전체 목록 출력(+ 페이지 네비게이션)
	public List<DetailList3DTO> getList(String type, String keyword, int start, int finish) throws Exception {
		Connection con = getConnection();
		// String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		String sql = "SELECT post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM used_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM used_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "ORDER BY post.post_no DESC";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		List<DetailList3DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList3DTO dldto = new DetailList3DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	
	// @@@@ 카테고리별 목록 메소드 @@@@ 
	// (목록)게시판/카테고리별 목록 메소드(+ 페이지 네비게이션)
	public List<DetailList3DTO> getList2(int start, int finish, long board_no, long used_cate_num) throws Exception {
		Connection con = getConnection();
		// String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM used_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM used_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE post.board_no=? AND post.used_cate_num=?" + "ORDER BY post.post_no DESC "
				+ ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, used_cate_num);
		ps.setInt(3, start);
		ps.setInt(4, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList3DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList3DTO dldto = new DetailList3DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}
	
	// (검색)게시판/카테고리별 목록 메소드(+ 페이지 네비게이션)
	public List<DetailList3DTO> getList2(String type, String keyword, int start, int finish, long board_no,
			long used_cate_num) throws Exception {
		Connection con = getConnection();
		// String sql ="SELECT * FROM used_post ORDER BY post_no DESC";
		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM used_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM used_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE post.board_no=? AND post.used_cate_num=?" + "ORDER BY post.post_no DESC "
				+ ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, used_cate_num);
		ps.setInt(3, start);
		ps.setInt(4, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList3DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList3DTO dldto = new DetailList3DTO(rs);
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

		while (rs.next()) {
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

		while (rs.next()) {
			UsedPostDTO updto = new UsedPostDTO(rs);

			list.add(updto);
		}

		con.close();

		return list;

	}

	// 게시글 수정
	public void edit(UsedPostDTO updto) throws Exception {
		Connection con = getConnection();

		String sql = "Update used_post SET post_title=?, used_cate_num=?,post_price=?,post_content=? where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, updto.getPost_title());
		ps.setLong(2, updto.getUsed_cate_num());
		ps.setLong(3, updto.getPost_price());
		ps.setString(4, updto.getPost_content());
		ps.setLong(5, updto.getPost_no());

		ps.execute();

		con.close();
	}

	// 게시글 삭제
	public void delete(long post_no) throws Exception {
		Connection con = getConnection();

		String sql = "Delete used_post where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, post_no);
		ps.execute();

		con.close();
	}

	// 검색/목록 구별하여 갯수 출력
	// (전체)목록인 경우
	public int getCount() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM used_post";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	// (전체)검색인 경우
	public int getCount(String type, String keyword) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM used_post WHERE instr(#1,?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}
	//(카테고리별)목록인 경우
	public int getCount2(long board_no, long used_cate_num) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM used_post WHERE board_no=? AND used_cate_num=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, used_cate_num);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	//(카테고리별)검색인 경우
	public int getCount2(String type, String keyword,long board_no, long used_cate_num) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM used_post WHERE instr(#1,?) > 0 AND board_no=? AND used_cate_num=?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setLong(2, board_no);
		ps.setLong(3, used_cate_num);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

}
