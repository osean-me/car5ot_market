package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import carrot.bean.dto.MannerDTO;
import carrot.bean.dto.MannerListDTO;

public class MannerDAO {

	private static DataSource src;

	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return src.getConnection();
	}

	// [1] 회원 가입 시 좋아요 테이블에 등록
	public void insertManner(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO MEMBER_MANNER VALUES(?, 50)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ps.execute();

		con.close();
	}

	// [2] 회원 좋아요 / 싫어요 갱신
	public void updateManner(long member_no, long manner_count) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE MEMBER_MANNER SET MANNER_COUNT = ? WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, manner_count);
		ps.setLong(2, member_no);

		ps.execute();

		con.close();
	}

	// [3] 누른 사람이 있는지 조회 > 감별
	public MannerListDTO getPushMember(long this_member_no, long push_member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER_MANNER_LIST WHERE THIS_MEMBER_NO = ? AND PUSH_MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, this_member_no);
		ps.setLong(2, push_member_no);

		ResultSet rs = ps.executeQuery();

		MannerListDTO mldto;

		if (rs.next()) {
			mldto = new MannerListDTO(rs);
		} else {
			mldto = null;
		}

		con.close();

		return mldto;
	}

	// [4] 해당 회원 매너지수 조회
	public MannerDTO getMannerCount(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER_MANNER WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		MannerDTO mdto;

		if (rs.next()) {
			mdto = new MannerDTO(rs);
		} else {
			mdto = null;
		}

		con.close();

		return mdto;
	}

	// [5-1] push 회원의 좋아요 갱신
	public void updatePush(long this_member_no, long push_member_no) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO MEMBER_MANNER_LIST VALUES(? , ?)";

		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setLong(1, this_member_no);
		ps.setLong(2, push_member_no);
		
		ps.execute();
		
		con.close();
	}

	public void deletePush(long this_member_no, long push_member_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "DELETE MEMBER_MANNER_LIST WHERE THIS_MEMBER_NO = ? AND PUSH_MEMBER_NO = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setLong(1, this_member_no);
		ps.setLong(2, push_member_no);
		
		ps.execute();
		
		con.close();
	}
	
	// [6-1] 회원 탈퇴 시 MEMBER_MANNER 테이블에서 데이터 지우기
	public void deleteManner(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "DELETE MEMBER_MANNER WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ps.execute();

		con.close();
	}

	// [6-2] 회원 탈퇴 시 모든 매너 테이블의 데이터 지우기
	public void dropManner(long this_member_no) throws Exception {

		// [6-1] MEMBER_MANNER 테이블에서 해당 회원 데이터 지우기
		this.deleteManner(this_member_no);

		Connection con = getConnection();

		String sql = "DELETE MEMBER_MANNER_LIST WHERE THIS_MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, this_member_no);

		ps.execute();

		con.close();
	}
}
