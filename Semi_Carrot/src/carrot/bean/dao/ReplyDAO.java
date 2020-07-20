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

import carrot.bean.dto.MemberDTO;
import carrot.bean.dto.ReplyDTO;

public class ReplyDAO {

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

	// [0] 드라이버 연결
	public Connection getConnection() throws Exception {
		return src.getConnection();
	}

	// [1] 시퀀스 발급
	public long getSequence(String reply_seq_name) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT #1.NEXTVAL FROM DUAL";

		sql = sql.replace("#1", reply_seq_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long result = rs.getLong(1);

		con.close();

		return result;
	}

	// [2] 댓글 단일 조회
	public ReplyDTO getReply(String reply_table_name, long reply_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM #1";

		sql = sql.replace("#1", reply_table_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		rs.next();

		ReplyDTO rdto = new ReplyDTO(rs);

		con.close();

		return rdto;
	}

	// [3] 댓글 등록
	public void writeReply(ReplyDTO rdto, String reply_table_name, String reply_seq_name) throws Exception {
		// 시퀀스번호 발급
		long seq_no = this.getSequence(reply_seq_name);

		if (rdto.getSuper_no() == 0) {
			// 새 글일 경우 > rdto 에는 5개의 정보가 들어있음.
			// 그룹번호 추가
			rdto.setGroup_no(seq_no);
		} else {
			// 답글일 경우 > rdto 에는 6개의 정보가 들어있음.
			// 추가로 그룹번호와 차수를 설정해준다.
			// 원본 댓글의 정보가 필요하므로 불러온다.
			ReplyDTO motherReply = this.getReply(reply_table_name, rdto.getSuper_no());
			// 원본글 그룹 번호 가지고 오기
			rdto.setGroup_no(motherReply.getGroup_no()); // 부모 댓글의 그룹 번호
			rdto.setDepth(motherReply.getDepth() + 1); // 부모 댓글의 차수 + 1
		}

		Connection con = getConnection();

		String sql = "INSERT INTO #1 VALUES(? , ? , ? , ? , ? , ? , ? , SYSDATE)";

		sql = sql.replace("#1", reply_table_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, seq_no);
		ps.setLong(2, rdto.getMember_no());
		ps.setLong(3, rdto.getPost_no());
		ps.setString(4, rdto.getReply_content());

		// 새글 혹은 답글
		if (rdto.getSuper_no() == 0) {
			// 새글일 경우
			ps.setNull(5, Types.NULL);
		} else {
			// 답글일 경우
			ps.setLong(5, rdto.getSuper_no());
		}

		ps.setLong(6, rdto.getGroup_no());
		ps.setLong(7, rdto.getDepth());

		ps.execute();

		con.close();
	}

	// [4] 해당 게시글 댓글 조회
	public List<ReplyDTO> postReply(String reply_table_name, long post_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT T.* FROM (SELECT * FROM #1 WHERE POST_NO = ? CONNECT BY PRIOR REPLY_NO=SUPER_NO START WITH SUPER_NO IS NULL ORDER SIBLINGS BY GROUP_NO DESC, REPLY_NO ASC) T";

		sql = sql.replace("#1", reply_table_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, post_no);

		ResultSet rs = ps.executeQuery();

		List<ReplyDTO> list = new ArrayList<ReplyDTO>();

		while (rs.next()) {
			ReplyDTO rdto = new ReplyDTO(rs);

			list.add(rdto);
		}

		con.close();

		return list;
	}

	// [5] 댓글 수정
	public void editReply(String reply_table_name, long reply_no, String reply_content) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE #1 SET REPLY_CONTENT = ? WHERE REPLY_NO = ?";

		sql = sql.replace("#1", reply_table_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, reply_content);
		ps.setLong(2, reply_no);

		ps.execute();

		con.close();
	}

	// [6] 댓글 삭제
	public void deleteReply(String reply_table_name, long reply_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE #1 WHERE REPLY_NO = ?";

		sql = sql.replace("#1", reply_table_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, reply_no);

		ps.execute();

		con.close();
	}

	// [7] super_no 로 부모 댓글 작성자 조회
	public String getMotherReplyNick(String reply_table_name, long super_no, long post_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT MEMBER_NO FROM #1 WHERE REPLY_NO = ? AND POST_NO = ?";

		sql = sql.replace("#1", reply_table_name);

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, super_no);
		ps.setLong(2, post_no);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long reply_member_no = rs.getLong(1);

		con.close();

		MemberDAO mdao = new MemberDAO();

		MemberDTO mdto = mdao.get(reply_member_no);

		String result = mdto.getMember_nick();

		return result;
	}

	// [8] 해당 회원 댓글 리스트 조회 > 게시글 번호 반환
	public List<Long> getMemberReplyList_used(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT POST_NO FROM USED_POST_REPLY WHERE MEMBER_NO = ? ORDER BY POST_NO DESC";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		List<Long> list = new ArrayList<Long>();

		while (rs.next()) {
			long post_no = rs.getLong("post_no");

			list.add(post_no);
		}

		con.close();

		return list;
	}

	// [8] 해당 회원 댓글 리스트 조회 > 게시글 번호 반환
	public List<Long> getMemberReplyList_promotion(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT POST_NO FROM PROMOTION_POST_REPLY WHERE MEMBER_NO = ? ORDER BY POST_NO DESC";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		List<Long> list = new ArrayList<Long>();

		while (rs.next()) {
			long post_no = rs.getLong("post_no");

			list.add(post_no);
		}

		con.close();

		return list;
	}

	// [9-1] 회원 댓글 갯구 구하기
	public long getReplyCount_used(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT COUNT(*) FROM USED_POST_REPLY WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long result = rs.getLong(1);

		con.close();

		return result;
	}

	// [9-2] 회원 댓글 갯구 구하기
	public long getReplyCount_promotion(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT COUNT(*) FROM PROMOTION_POST_REPLY WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long result = rs.getLong(1);

		con.close();

		return result;
	}
}
