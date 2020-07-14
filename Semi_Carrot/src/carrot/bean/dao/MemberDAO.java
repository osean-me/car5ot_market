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

	// 회원정보-상세조회(long>string으로 변환)
	public MemberDTO get(String member_id) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER WHERE MEMBER_id=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, member_id);

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

	// [5] 비밀번호 찾기 메소드
	public String findPW(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT member_pw FROM member WHERE member_id=? and member_nick=? and member_phone=?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_nick());
		ps.setString(3, mdto.getMember_phone());

		ResultSet rs = ps.executeQuery();

		String member_pw;

		if (rs.next()) {
			member_pw = rs.getString("member_pw");
		} else {
			member_pw = null;
		}

		con.close();

		return member_pw;
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

	// [7] 로그인 갱신
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

	// [8]정보 변경 메소드
	public void changeInfo(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE MEMBER SET MEMBER_NICK = ?, MEMBER_ADDR_NO = ?, MEMBER_PHONE = ? WHERE MEMBER_NO = ?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, mdto.getMember_nick());
		ps.setLong(2, mdto.getMember_addr_no());
		ps.setString(3, mdto.getMember_phone());
		ps.setLong(4, mdto.getMember_no());
		ps.execute();

		con.close();
	}

	// [8]정보 변경 + 비밀번호 변경 메소드
	public void changeInfoWithPw(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE MEMBER SET MEMBER_PW = ?, MEMBER_NICK = ?, MEMBER_ADDR_NO = ?, MEMBER_PHONE = ? WHERE MEMBER_NO = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1, mdto.getMember_pw());
		ps.setString(2, mdto.getMember_nick());
		ps.setLong(3, mdto.getMember_addr_no());
		ps.setString(4, mdto.getMember_phone());
		ps.setLong(5, mdto.getMember_no());
		ps.execute();

		con.close();
	}

	// [8]정보 변경 메소드//관리자모드
	public void changeInfoadmin(MemberDTO mdto) throws Exception {
		Connection con = getConnection();

		String sql = "UPDATE member SET " + "member_nick=?, member_addr_no=?, member_phone=? " + "WHERE member_no=?"
				+ "WHERE member_auth=?";
		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, mdto.getMember_nick());
		ps.setLong(2, mdto.getMember_addr_no());
		ps.setString(3, mdto.getMember_phone());
		ps.setLong(4, mdto.getMember_no());
		ps.setString(5, mdto.getMember_auth());
		ps.execute();

		con.close();
	}

	// (관리자) 회원 검색 기능
	public List<MemberDTO> search(String member_id) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM MEMBER WHERE instr(member_id,?) > 0 ORDER BY member_id ASC";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, member_id);
		ResultSet rs = ps.executeQuery();

		List<MemberDTO> list = new ArrayList<>();
		while (rs.next()) {
			MemberDTO mdto = new MemberDTO(rs);
			list.add(mdto);
		}
		con.close();
		return list;
	}

	// 회원검색(타입추가)

	public List<MemberDTO> search(String type, String keyword) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM member WHERE instr(#1, ?) > 0 ORDER BY #1 ASC";
		sql = sql.replace("#1", type);
		System.out.println("sql = " + sql);

		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<MemberDTO> list = new ArrayList<>();
		while (rs.next()) {
			MemberDTO mdto = new MemberDTO(rs);
			list.add(mdto);
		}

		con.close();

		return list;
	}

	// [8] 회원 탈퇴
	//탈퇴 메소드
		public void exit(long member_no) throws Exception{
			Connection con = getConnection();
			
			String sql = "DELETE member WHERE member_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setLong(1, member_no);
			ps.execute();
			
			con.close();
		}

	// [8] 관리자가 회원 탈퇴 (long>string으로 변환)
	public int exitMember(String member_id) throws Exception {

		Connection con = getConnection();

		String sql = "DELETE MEMBER WHERE MEMBER_ID = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, member_id);

		int result = ps.executeUpdate();

		con.close();

		return result;
	}

}
