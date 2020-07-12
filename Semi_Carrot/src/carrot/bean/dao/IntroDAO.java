package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.IntroDTO;

public class IntroDAO {

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

	// [1] 자기소개 작성
	public void writeIntro(IntroDTO idto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO MEMBER_INTRO VALUES(? , ?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, idto.getMember_no());
		ps.setString(2, idto.getIntro());

		ps.execute();

		con.close();
	}

	// [2] 자기소개 수정
	public void editIntro(IntroDTO idto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE MEMBER_INTRO SET INTRO = ? WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, idto.getIntro());
		ps.setLong(2, idto.getMember_no());

		ps.execute();

		con.close();
	}

	// [3] 자기소개 불러오기
	public String getIntro(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT INTRO FROM MEMBER_INTRO WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		String result = null;

		if (rs.next()) {

			result = rs.getString("INTRO");
			
		}

		con.close();

		return result;

	}
}
