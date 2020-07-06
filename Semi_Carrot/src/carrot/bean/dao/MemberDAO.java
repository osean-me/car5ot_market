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
		
		while(rs.next()) {
			MemberDTO mdto = new MemberDTO(rs);
			
			list.add(mdto);
		}
		
		con.close();
		
		return list;
	}
	//로그인 메소드
	public MemberDTO login(MemberDTO mdto)throws Exception{
		Connection con = getConnection();
	
		String sql = "SELECT * FROM member WHERE member_id=? AND member_pw=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, mdto.getMember_id());
		ps.setString(2, mdto.getMember_pw());
		ResultSet rs=ps.executeQuery();
		
		MemberDTO user;
		if(rs.next()) {//데이터가 있으면
			user = new MemberDTO();
			
			user.setMember_no(rs.getLong("member_no"));
			user.setMember_id(rs.getString("member_id"));
			user.setMember_pw(rs.getString("member_pw"));
			user.setMember_addr_no(rs.getLong("member_addr_no"));
			user.setMember_nick(rs.getString("member_nick"));
			user.setMember_phone(rs.getString("member_phone"));
			user.setMember_auth(rs.getString("member_auth"));
			user.setMember_join(rs.getString("member_join"));
			user.setMember_login(rs.getString("member_login"));
			user.setMember_join(rs.getString("member_buy"));
			user.setMember_join(rs.getString("member_sell"));
			user.setMember_join(rs.getString("member_like"));
		}
		else {
			user = null;
		}
		
		con.close();
		
		return user;
}
//로그인 갱신
	public void updateLoginTime(String id) throws Exception{
		Connection con =getConnection();
		
		String sql ="UPDATE member SET member_login=sysdate WHERE member_id=?";
		PreparedStatement ps =con.prepareStatement(sql);
		ps.setString(1, id);
		ps.execute();
		
		con.close();
	}
	}
