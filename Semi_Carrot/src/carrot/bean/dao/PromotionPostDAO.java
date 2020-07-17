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
import carrot.bean.dto.RecoPromotionPostDTO;
import carrot.bean.dto.RecoUsedPostDTO;

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
	/*
	 * // 주소+사진 포함 전체 목록 메소드 public List<DetailList2DTO> getList() throws Exception
	 * { Connection con = getConnection(); String sql =
	 * "SELECT post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
	 * + "FROM promotion_post post " + "INNER JOIN " +
	 * "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
	 * + "ON post.post_no = img.post_no	 " +
	 * "INNER JOIN address addr ON post.addr_no = addr.addr_no "+
	 * "ORDER BY post.post_no DESC"; PreparedStatement ps =
	 * con.prepareStatement(sql);
	 * 
	 * ResultSet rs = ps.executeQuery(); List<DetailList2DTO> list = new
	 * ArrayList<>(); while(rs.next()) { DetailList2DTO dldto = new
	 * DetailList2DTO(rs);
	 * 
	 * list.add(dldto); } con.close(); return list; }
	 * 
	 * // 주소+사진 포함 게시판/카테고리별 목록 메소드 public List<DetailList2DTO> getList2(long
	 * board_no, long promotion_cate_num) throws Exception { Connection con =
	 * getConnection(); String sql =
	 * "SELECT post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
	 * + "FROM promotion_post post " + "INNER JOIN " +
	 * "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
	 * + "ON post.post_no = img.post_no " +
	 * "INNER JOIN address addr ON post.addr_no = addr.addr_no " +
	 * "WHERE post.board_no=? AND post.promotion_cate_num=?";
	 * 
	 * PreparedStatement ps = con.prepareStatement(sql); ps.setLong(1, board_no);
	 * ps.setLong(2, promotion_cate_num);
	 * 
	 * ResultSet rs = ps.executeQuery(); List<DetailList2DTO> list = new
	 * ArrayList<>(); while(rs.next()) { DetailList2DTO dldto = new
	 * DetailList2DTO(rs);
	 * 
	 * list.add(dldto); } con.close(); return list; }
	 */

	// @@@@ 전체 목록 메소드 @@@@

	// 비회원일때) 전체 목록 출력(+ 페이지 네비게이션)
	public List<DetailList2DTO> getList(int start, int finish) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "ORDER BY post.post_no DESC " + ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, start);
		ps.setInt(2, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// 비회원일때) 전체 검색 목록 출력(+ 페이지 네비게이션)
	public List<DetailList2DTO> getList(String type, String keyword, int start, int finish) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	" + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE instr(#1, ?) > 0 " + "ORDER BY post.post_no DESC " + ") WHERE rn BETWEEN ? AND ?";

		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, start);
		ps.setInt(3, finish);

		ResultSet rs = ps.executeQuery();
		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// 회원일때 ) 전체 목록 출력
	public List<DetailList2DTO> getAreaList(int start, int finish, long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE post.addr_no=?" + "ORDER BY post.post_no DESC " + ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, member_addr_no);
		ps.setInt(2, start);
		ps.setInt(3, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// 회원일때 ) 검색 목록 출력
	public List<DetailList2DTO> getAreaList(String type, String keyword, int start, int finish, long member_addr_no)
			throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	" + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE instr(#1, ?) > 0 AND post.addr_no=? " + "ORDER BY post.post_no DESC "
				+ ") WHERE rn BETWEEN ? AND ?";

		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setLong(2, member_addr_no);
		ps.setInt(3, start);
		ps.setInt(4, finish);

		ResultSet rs = ps.executeQuery();
		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// @@@@ 카테고리별 목록 메소드 @@@@
	// (비회원) 게시판/카테고리별 목록 메소드(+ 페이지 네비게이션)
	public List<DetailList2DTO> getList2(int start, int finish, long board_no, long promotion_cate_num)
			throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE post.board_no=? AND post.promotion_cate_num=?" + "ORDER BY post.post_no DESC "
				+ ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, promotion_cate_num);
		ps.setInt(3, start);
		ps.setInt(4, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// (회원) 게시판/카테고리별 목록 메소드(+ 페이지 네비게이션)
	public List<DetailList2DTO> getList2(int start, int finish, long board_no, long promotion_cate_num,
			long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM( "
				+ "SELECT ROWNUM rn, post.*, img.post_img_no , addr.addr_state, addr.addr_city, addr.addr_base "
				+ "FROM promotion_post post " + "INNER JOIN "
				+ "(SELECT post_no, min(post_img_no) post_img_no FROM promotion_post_img GROUP BY post_no) img "
				+ "ON post.post_no = img.post_no	 " + "INNER JOIN address addr ON post.addr_no = addr.addr_no "
				+ "WHERE post.board_no=? AND post.promotion_cate_num=? AND post.addr_no=?"
				+ "ORDER BY post.post_no DESC " + ") WHERE rn BETWEEN ? AND ?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, promotion_cate_num);
		ps.setLong(3, member_addr_no);
		ps.setInt(4, start);
		ps.setInt(5, finish);
		ResultSet rs = ps.executeQuery();

		List<DetailList2DTO> list = new ArrayList<>();
		while (rs.next()) {
			DetailList2DTO dldto = new DetailList2DTO(rs);
			list.add(dldto);
		}
		con.close();
		return list;
	}

	// 비회원(전체)목록인 경우
	public int getCount() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM promotion_post";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	// 비회원(전체)검색인 경우
	public int getCount(String type, String keyword) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM promotion_post WHERE instr(#1,?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	// 검색/목록 구별하여 갯수 출력
	// 회원(전체)목록인 경우
	public int getCount(long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM promotion_post where addr_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, member_addr_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	// 회원(전체)검색인 경우
	public int getCount(String type, String keyword, long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM promotion_post WHERE instr(#1,?) > 0 AND addr_no=?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setLong(2, member_addr_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	// 회원(카테고리별)목록인 경우
	public int getCount2(long board_no, long promotion_cate_num, long member_addr_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM promotion_post WHERE board_no=? AND promotion_cate_num=? AND addr_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, promotion_cate_num);
		ps.setLong(3, member_addr_no);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
	}

	// 비회원(카테고리별)목록인 경우
	public int getCount2(long board_no, long promotion_cate_num) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT count(*) FROM promotion_post WHERE board_no=? AND promotion_cate_num=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, board_no);
		ps.setLong(2, promotion_cate_num);

		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);

		con.close();
		return count;
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
	public List<PromotionPostDTO> newPromotionPost(long member_addr_no) throws Exception {
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
	//같은 동네&같은 카테고리 최신글 조회(1~18)
	public RecoPromotionPostDTO getRecoList(long addr_no, long promotion_cate_num, int count) throws Exception {
		Connection con = getConnection();
		String sql="SELECT * FROM (SELECT ROWNUM rn, pp.post_no, pp.post_title, pp.ADDR_NO,pp.promotion_CATE_NUM,img.imgno FROM promotion_post pp INNER JOIN(SELECT post_no, min(post_img_no) imgno FROM promotion_post_img GROUP BY post_no ORDER BY post_no desc) img ON pp.post_no = img.post_no AND pp.ADDR_NO =? AND pp.promotion_CATE_NUM =? ORDER BY post_date DESC) WHERE rn = ?";
	
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, addr_no);
		ps.setLong(2, promotion_cate_num);
		ps.setInt(3, count);

		ResultSet rs = ps.executeQuery();

		rs.next();

		RecoPromotionPostDTO rppdto = new RecoPromotionPostDTO(rs);

		con.close();

		return rppdto;
	}
	
	// 같은 동네&같은 카테고리 최신글 조회 (1~18) COUNT
	public long getRecoCount(long addr_no, long promotion_cate_num) throws Exception {
		Connection con = getConnection();
		
		String sql="SELECT count(*) FROM(SELECT ROWNUM rn, pp.post_no, pp.post_title, pp.ADDR_NO,pp.Promotion_CATE_NUM,img.imgno FROM promotion_post pp INNER JOIN(SELECT post_no, min(post_img_no) imgno FROM promotion_post_img GROUP BY post_no ORDER BY post_no desc)img ON pp.post_no = img.post_no AND pp.ADDR_NO =? AND pp.promotion_CATE_NUM =? ORDER BY post_date DESC) WHERE rn BETWEEN 1 AND 18";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, addr_no);
		ps.setLong(2, promotion_cate_num);

		ResultSet rs = ps.executeQuery();
		rs.next();
		long count = rs.getLong(1);

		con.close();

		return count;
	}
}
