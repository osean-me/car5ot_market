package carrot.bean.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RecoPromotionPostDTO {
	private long post_no;
	private String post_title;
	private long addr_no;
	private long imgno;
	
	public RecoPromotionPostDTO(ResultSet rs) throws SQLException {
		this.setPost_no(rs.getLong("post_no"));
		this.setPost_title(rs.getString("post_title"));
		this.setAddr_no(rs.getLong("addr_no"));
		this.setImgno(rs.getLong("imgno"));
	}
	
	public long getPost_no() {
		return post_no;
	}
	public void setPost_no(long post_no) {
		this.post_no = post_no;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public long getAddr_no() {
		return addr_no;
	}
	public void setAddr_no(long addr_no) {
		this.addr_no = addr_no;
	}
	public long getImgno() {
		return imgno;
	}
	public void setImgno(long imgno) {
		this.imgno = imgno;
	}
	public RecoPromotionPostDTO() {
		super();
	}
}
