package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.CommunityPostDTO;
import carrot.bean.dto.PromotionPostDTO;
import carrot.bean.dto.UsedPostDTO;

public class BoardDAO {
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

	// 게시판 별 게시글 테이블 이름 받아오기
	public String[] getPostTableName() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT POST_TABLE_NAME FROM BOARD";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		String[] result = new String[3];
		while(rs.next()) {
			
			result[rs.getRow()-1] = rs.getString(1);
		}

		con.close();

		return result;
	}

	// 게시판 번호 받아오기
	public long[] getBoardNo() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT BOARD_NO FROM BOARD;";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		int index = 0;

		long[] board_no = { 0, 0, 0 };

		while (rs.next()) {
			board_no[index] = rs.getLong(1);

			index++;
		}

		con.close();

		return board_no;
	}

	// 게시판 별 게시글 가져오기
	public List<Object> getPostList(String post_board_name, long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM #1 WHERE MEMBER_NO = ?";

		sql = sql.replace("#1", post_board_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		String name = post_board_name;

		List<Object> list = new ArrayList<Object>();
		
		Object postDTO;
		
		while (rs.next()) {

			if (name.equals("USED_POST")) {
				postDTO = new UsedPostDTO(rs);

			} else if (name.equals("PROMOTION_POST")) {
				postDTO = new PromotionPostDTO(rs);

			} else if (name.equals("COMMUNITY_POST")) {
				postDTO = new CommunityPostDTO(rs);

			} else {
				postDTO = null;
			}

			list.add(postDTO);
		}

		con.close();

		return list;
	}
}
