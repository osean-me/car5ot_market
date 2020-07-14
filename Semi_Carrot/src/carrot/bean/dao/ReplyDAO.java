package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
		if (rdto.getSuper_no() == 0) {
			// 새 글일 경우 > rdto 에는 5개의 정보가 들어있음.
			// 그룹번호 추가
			rdto.setGroup_no(rdto.getReply_no());
		} else {
			// 답글일 경우 > rdto 에는 6개의 정보가 들어있음.
			// 추가로 그룹번호와 차수를 설정해준다.
			// 원본 댓글의 정보가 필요하므로 불러온다.
			ReplyDTO motherReply = this.getReply(reply_table_name, rdto.getSuper_no());
			// 원본글 그룹 번호 가지고 오기
			rdto.setGroup_no(motherReply.getGroup_no()); // 부모 댓글의 그룹 번호
			rdto.setDepth(motherReply.getDepth() + 1); // 부모 댓글의 차수 + 1
		}

		// 시퀀스번호 발급
		long seq_no = this.getSequence(reply_seq_name);

		Connection con = getConnection();

		String sql = "INSERT INTO #1 VALUES(? , ? , ? , ? , ? , ? , ? , SYSDATE)";

		sql = sql.replace("#1", reply_table_name);
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setLong(1, seq_no);
		ps.setLong(2, rdto.getMember_no());
		ps.setLong(3, rdto.getPost_no());
		ps.setString(4, rdto.getReply_content());
		
		// 새글 혹은 답글
		if(rdto.getSuper_no() == 0) {
			// 새글일 경우
			ps.setNull(5, Types.INTEGER);
		} else {
			// 답글일 경우
			ps.setLong(5, rdto.getSuper_no());
		}
		
		ps.setLong(6, rdto.getGroup_no());
		ps.setLong(7, rdto.getDepth());
		
		ps.execute();
		
		con.close();
	}
}
