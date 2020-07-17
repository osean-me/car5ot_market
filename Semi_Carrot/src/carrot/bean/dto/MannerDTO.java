package carrot.bean.dto;

import java.sql.ResultSet;

public class MannerDTO {
	private long member_no;
	private long manner_count;

	public MannerDTO() {
		super();
	}
	
	public MannerDTO(ResultSet rs) throws Exception {
		this.setMember_no(rs.getLong("member_no"));
		this.setManner_count(rs.getLong("manner_count"));
	}

	public long getMember_no() {
		return member_no;
	}

	public void setMember_no(long member_no) {
		this.member_no = member_no;
	}

	public long getManner_count() {
		return manner_count;
	}

	public void setManner_count(long manner_count) {
		this.manner_count = manner_count;
	}

}
