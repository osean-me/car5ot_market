package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.LikeDTO;

public class LikeDAO {
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

	// [1] 회원 찜 등록
	public void insertLike(LikeDTO ldto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO POST_LIKE VALUES(? , ? , ?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, ldto.getMember_no());
		ps.setLong(2, ldto.getBoard_no());
		ps.setLong(3, ldto.getPost_no());

		ps.execute();

		con.close();
	}

	// [2] 회원 찜 삭제
	public void deleteLike(LikeDTO ldto) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE POST_LIKE WHERE MEMBER_NO = ? AND BOARD_NO = ? AND POST_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, ldto.getMember_no());
		ps.setLong(2, ldto.getBoard_no());
		ps.setLong(3, ldto.getPost_no());

		ps.execute();

		con.close();
	}

	// [3] 회원 찜 조회
	public Long searchLike(LikeDTO ldto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT POST_NO FROM POST_LIKE WHERE MEMBER_NO = ? AND BOARD_NO = ? AND POST_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, ldto.getMember_no());
		ps.setLong(2, ldto.getBoard_no());
		ps.setLong(3, ldto.getPost_no());

		ResultSet rs = ps.executeQuery();

		Long result;

		if (rs.next()) {
			result = rs.getLong(1);
		} else {
			result = null;
		}

		con.close();

		return result;
	}

	// [4] 게시글 좋아요 수 조회
	public Long getPostLikeCount(String post_table, long post_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT POST_LIKE FROM #1 WHERE POST_NO = ?";

		sql = sql.replace("#1", post_table);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, post_no);

		ResultSet rs = ps.executeQuery();

		Long result;

		if (rs.next()) {
			result = rs.getLong(1);
		} else {
			result = null;
		}

		con.close();

		return result;
	}

	// [5] 게시글 좋아요 수정
	public void editPostLike(String post_table, long post_no, long post_like_count) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE #1 SET POST_LIKE = ? WHERE POST_NO = ?";

		sql = sql.replace("#1", post_table);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, post_like_count);
		ps.setLong(2, post_no);

		ps.execute();

		con.close();
	}
	
//	// [6] 회원의 찜목록 불러오기
//	public List<Object> getPostLikeList(long member_no) throws Exception {
//		List<Integer> list = new ArrayList<Integer>();
//		
//		Integer a = new Integer[2];
//		
//		list.add(a);
//		
//		Connection con = getConnection();
//		
//		String sql = "SELECT BOARD_NO, POST_NO FROM POST_LIKE WHERE MEMBER_NO = ?";
//		
//		PreparedStatement ps = con.prepareStatement(sql);
//		
//		ps.setLong(1, member_no);
//		
//		ResultSet rs = ps.executeQuery();
//	}

}
