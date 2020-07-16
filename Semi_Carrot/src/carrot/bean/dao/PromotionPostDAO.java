
package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.DetailList2DTO;
import carrot.bean.dto.PromotionPostDTO;

public class PromotionPostDAO {
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
	public void write(PromotionPostDTO updto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO promotion_post " + "( " + "post_no, " + "post_title, " + "post_content, "
				+ "post_price, " + "post_date, " + "post_phone, " + "post_view, " + "post_like, "
				+ "promotion_cate_num, " + "member_no, " + "addr_no, " + "board_no " + ") "
				+ "VALUES(?,?,?,?,sysdate,?,0,0,?,?,?,?)";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, updto.getPost_no());
		ps.setString(2, updto.getPost_title());
		ps.setString(3, updto.getPost_content());
		ps.setLong(4, updto.getPost_price());
		ps.setString(5, updto.getPost_phone());
		ps.setLong(6, updto.getPromotion_cate_num());
		ps.setLong(7, updto.getMember_no());
		ps.setLong(8, updto.getAddr_no());
		ps.setLong(9, updto.getBoard_no());
		ps.execute();

		con.close();

	}

	// 글 목록 메소드
	public List<PromotionPostDTO> getList2() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT * FROM promotion_post ORDER BY post_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		List<PromotionPostDTO> list = new ArrayList<>();
		while (rs.next()) {
			PromotionPostDTO updto = new PromotionPostDTO(rs);
			list.add(updto);
		}
		con.close();
		return list;
	}

	// 주소+사진 포함 게시판/카테고리별 목록 메소드
	public List<DetailList2DTO> getList(long board_no, long promotion_cate_num) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE post.board_no=? AND post.promotion_cate_num=?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, promotion_cate_num);

		ResultSet rs = ps.executeQuery();
		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);

			list.add(dldto);
		}
		con.close();
		return list;
	}

	// 주소+사진 포함 전체 목록 메소드
	public List<DetailList2DTO> getList() throws Exception {
		Connection con = getConnection();
		String sql = "SELECT post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "ORDER BY post.post_no DESC";
		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();
		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);

			list.add(dldto);
		}
		con.close();
		return list;
	}

	// 단일조회
	public PromotionPostDTO get(long post_no) throws Exception {
		Connection con = getConnection();

		String sql = "Select * from promotion_post where post_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, post_no);
		ResultSet rs = ps.executeQuery();

		PromotionPostDTO updto = rs.next() ? new PromotionPostDTO(rs) : null;

		con.close();

		return updto;
	}

	// 조회수 증가
	public void plusViewCount(long post_no, long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "update promotion_post set post_view = post_view+1 where post_no=? and member_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, post_no);
		ps.setLong(2, member_no);
		ps.execute();

		con.close();
	}

	// 메인 페이지 최신 홍보 게시물 조회 1
	public List<PromotionPostDTO> newPromotionPost() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM (SELECT ROWNUM RN, T.* FROM (SELECT A.* FROM PROMOTION_POST A LEFT OUTER JOIN ADDRESS B ON A.ADDR_NO = B.ADDR_NO ORDER BY A.POST_DATE DESC) T ) WHERE RN BETWEEN 1 AND 10";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		List<PromotionPostDTO> list = new ArrayList<PromotionPostDTO>();

		while (rs.next()) {
			PromotionPostDTO ppdto = new PromotionPostDTO(rs);

			list.add(ppdto);
		}

		con.close();

		return list;
	}

	// 메인 페이지 최신 홍보 게시물 조회 2 (로그인일 경우)
	public List<PromotionPostDTO> newpPromotionPost(long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM (SELECT ROWNUM RN, T.* FROM (SELECT A.* FROM PROMOTION_POST A LEFT OUTER JOIN ADDRESS B ON A.ADDR_NO = B.ADDR_NO WHERE A.ADDR_NO = ? ORDER BY A.POST_DATE DESC) T ) WHERE RN BETWEEN 1 AND 10";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_addr_no);

		ResultSet rs = ps.executeQuery();

		List<PromotionPostDTO> list = new ArrayList<PromotionPostDTO>();

		while (rs.next()) {
			PromotionPostDTO ppdto = new PromotionPostDTO(rs);

			list.add(ppdto);
		}

		con.close();

		return list;
	}

	// 회원 거주 지역 게시글 조회
	public List<PromotionPostDTO> memberLocalPromotionPost(long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM PROMOTION_POST WHERE ADDR_NO = ? ORDER BY POST_DATE DESC";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_addr_no);

		ResultSet rs = ps.executeQuery();

		List<PromotionPostDTO> list = new ArrayList<PromotionPostDTO>();

		while (rs.next()) {
			PromotionPostDTO ppdto = new PromotionPostDTO(rs);

			list.add(ppdto);
		}

		con.close();

		return list;

	}

}
