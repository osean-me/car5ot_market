package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import carrot.bean.dto.ProfileImgDTO;

public class ProfileImgDAO {

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

	// [1] 시퀀스 발급
	public long getSequence() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT PROFILE_IMG_SEQ.NEXTVAL FROM DUAL";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long result = rs.getLong(1);

		con.close();

		return result;
	}

	// [2] 프로필 이미지 저장
	public long profileSave(ProfileImgDTO pidto) throws Exception {

		// 시퀀스 번호 발급 메소드
		long member_img_no = getSequence();

		Connection con = getConnection();

		String sql = "INSERT INTO PROFILE_IMG VALUES(?, ?, ?, ?, ?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_img_no);
		ps.setLong(2, pidto.getMember_no());
		ps.setString(3, pidto.getMember_img_name());
		ps.setString(4, pidto.getMember_img_type());
		ps.setLong(5, pidto.getMember_img_size());

		ps.execute();

		con.close();

		return member_img_no;
	}

	// [3] 프로필 이미지 단일 조회
	public ProfileImgDTO get(long member_img_no) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT * FROM PROFILE_IMG WHERE MEMBER_IMG_NO = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, member_img_no);

		ResultSet rs = ps.executeQuery();

		rs.next();

		ProfileImgDTO pidto = new ProfileImgDTO(rs);

		con.close();

		return pidto;
	}

	// [4] 회원 이미지 번호 조회
	public Long getProfileImgNo(long member_no) throws Exception {
		Connection con = getConnection();
		
		String sql = "SELECT MEMBER_IMG_NO FROM PROFILE_IMG WHERE MEMBER_NO = ?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setLong(1, member_no);
		
		ResultSet rs = ps.executeQuery();
		
		Long result;
		
		if(rs.next()) {
			
			result = rs.getLong(1);
		} else {
			
			result = null;
		}
		
		con.close();
		
		return result;
	}
	
	// [5] 회원 이미지 DB 조회
		public ProfileImgDTO getProfileImg(long member_img_no) throws Exception {
			Connection con = getConnection();
			
			String sql = "SELECT * FROM PROFILE_IMG WHERE MEMBER_IMG_NO = ?";
			
			PreparedStatement ps = con.prepareStatement(sql);
			
			ps.setLong(1, member_img_no);
			
			ResultSet rs = ps.executeQuery();
			
			rs.next();
			
			ProfileImgDTO pidto = new ProfileImgDTO(rs);
			
			con.close();
			
			return pidto;
		}
}
