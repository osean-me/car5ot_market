package carrot.bean.dto;

import java.sql.ResultSet;

public class IntroDTO {
	private long member_no;
	private String intro;

	public IntroDTO() {
		super();
	}

	public IntroDTO(ResultSet rs) throws Exception {
		this.setMember_no(rs.getLong("member_no"));
		this.setIntro(rs.getString("intro"));

	}

	public long getMember_no() {
		return member_no;
	}

	public void setMember_no(long member_no) {
		this.member_no = member_no;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

}
