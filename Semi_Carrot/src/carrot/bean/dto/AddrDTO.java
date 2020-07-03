package carrot.bean.dto;

import java.sql.ResultSet;

public class AddrDTO {
	private long addr_no;
	private String addr_state;
	private String addr_city;
	private String addr_base;

	public AddrDTO() {
		super();
	}

	public AddrDTO(ResultSet rs) throws Exception {
		this.setAddr_no(rs.getLong("ADDR_NO"));
		this.setAddr_state(rs.getString("ADDR_STATE"));
		this.setAddr_city(rs.getString("ADDR_CITY"));
		this.setAddr_base(rs.getString("ADDR_BASE"));
	}

	public long getAddr_no() {
		return addr_no;
	}

	public void setAddr_no(long addr_no) {
		this.addr_no = addr_no;
	}

	public String getAddr_state() {
		return addr_state;
	}

	public void setAddr_state(String addr_state) {
		this.addr_state = addr_state;
	}

	public String getAddr_city() {
		return addr_city;
	}

	public void setAddr_city(String addr_city) {
		this.addr_city = addr_city;
	}

	public String getAddr_base() {
		return addr_base;
	}

	public void setAddr_base(String addr_base) {
		this.addr_base = addr_base;
	}

}
