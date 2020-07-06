package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.MemberDTO;

public class MemberDAO {

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

	// [1] 회원번호 발급
	public long getMemberNo() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT MEMBER_SEQ.NEXTVAL FROM DUAL";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long result = rs.getLong(1);

		con.close();

		return result;
	}

	// [2] 회원가입 기능
	public void join(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO MEMBER VALUES(? , ? , ? , ? , ? , ? , '일반' , SYSDATE , NULL)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, mdto.getMember_no());
		ps.setString(2, mdto.getMember_id());
		ps.setString(3, mdto.getMember_pw());
		ps.setLong(4, mdto.getMember_addr_no());
		ps.setString(5, mdto.getMember_nick());
		ps.setString(6, mdto.getMember_phone());

		ps.execute();

		con.close();
	}

	// [3] 회원 단일 조회
	public MemberDTO get(long member_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER WHERE MEMBER_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_no);

		ResultSet rs = ps.executeQuery();

		MemberDTO mdto;

		if (rs.next()) {
			mdto = new MemberDTO(rs);
		} else {
			mdto = null;
		}

		con.close();

		return mdto;
	}

	// [4] 전체 회원 조회
	public List<MemberDTO> getMember() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		List<MemberDTO> list = new ArrayList<MemberDTO>();

		while (rs.next()) {
			MemberDTO mdto = new MemberDTO(rs);

			list.add(mdto);
		}

		con.close();

		return list;
	}

	// [5] 아이디 찾기 메소드
	public String findId(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT member_id FROM member " + "WHERE member_nick=? and member_phone=?";

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_nick());
		ps.setString(2, mdto.getMember_phone());
		ResultSet rs = ps.executeQuery();

		String member_id;
		if (rs.next()) {
			member_id = rs.getString("member_id");
		} else {
			member_id = null;
		}

		con.close();

		return member_id;
	}

	// [6] 로그인 메소드
	public MemberDTO login(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER WHERE MEMBER_ID = ? AND MEMBER_PW = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_pw());
		
		ResultSet rs = ps.executeQuery();

		if (rs.next()) {// 데이터가 있으면
			
			mdto = new MemberDTO(rs);

		} else {
			
			mdto = null;
			
		}

		con.close();

		return mdto;
	}

	// [7]로그인 갱신
	public int updateLoginTime(String member_id, String member_pw) throws Exception {
		
		Connection con = getConnection();

		String sql = "UPDATE MEMBER SET MEMBER_LOGIN = SYSDATE WHERE MEMBER_ID = ? AND MEMBER_PW = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, member_id);
		ps.setString(2, member_pw);
		
		int result = ps.executeUpdate();

		con.close();
		
		return result;
	}
}
