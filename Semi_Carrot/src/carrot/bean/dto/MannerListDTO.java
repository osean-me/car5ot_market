package carrot.bean.dto;

import java.sql.ResultSet;

public class MannerListDTO {
	private long this_member_no;
	private long push_member_no;

	public MannerListDTO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MannerListDTO(ResultSet rs) throws Exception {
		this.setThis_member_no(rs.getLong("this_member_no"));
		this.setPush_member_no(rs.getLong("push_member_no"));
	}

	public long getThis_member_no() {
		return this_member_no;
	}

	public void setThis_member_no(long this_member_no) {
		this.this_member_no = this_member_no;
	}

	public long getPush_member_no() {
		return push_member_no;
	}

	public void setPush_member_no(long push_member_no) {
		this.push_member_no = push_member_no;
	}

}
