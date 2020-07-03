package carrot.bean.dto;

import java.sql.ResultSet;

public class MemberDTO {
	private long member_no;
	private String member_id;
	private String member_pw;
	private long member_addr_no;
	private String member_nick;
	private long member_phone;
	private String member_auth;
	private String member_join;
	private String member_login;

	public MemberDTO() {
		super();
	}

	public MemberDTO(ResultSet rs) throws Exception {
		this.setMember_no(rs.getLong("MEMBER_NO"));
		this.setMember_id(rs.getString("MEMBER_ID"));
		this.setMember_pw(rs.getString("MEMBER_PW"));
		this.setMember_addr_no(rs.getLong("MEMBER_ADDR_NO"));
		this.setMember_nick(rs.getString("MEMBER_NICK"));
		this.setMember_phone(rs.getLong("MEMBER_PHONE"));
		this.setMember_auth(rs.getString("MEMBER_AUTH"));
		this.setMember_join(rs.getString("MEMBER_JOIN"));
		this.setMember_login(rs.getString("MEMBER_LOGIN"));
	}

	public long getMember_no() {
		return member_no;
	}

	public void setMember_no(long member_no) {
		this.member_no = member_no;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_pw() {
		return member_pw;
	}

	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}

	public long getMember_addr_no() {
		return member_addr_no;
	}

	public void setMember_addr_no(long member_addr_no) {
		this.member_addr_no = member_addr_no;
	}

	public String getMember_nick() {
		return member_nick;
	}

	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}

	public long getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(long member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_auth() {
		return member_auth;
	}

	public void setMember_auth(String member_auth) {
		this.member_auth = member_auth;
	}

	public String getMember_join() {
		return member_join;
	}

	public void setMember_join(String member_join) {
		this.member_join = member_join;
	}

	public String getMember_login() {
		return member_login;
	}

	public void setMember_login(String member_login) {
		this.member_login = member_login;
	}

}
