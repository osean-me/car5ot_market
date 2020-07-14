package carrot.bean.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UsedPostImgDTO {
	private long post_img_no;
	private long post_no;
	private String post_img_name;
	private String post_img_type;
	private long post_img_size;
	
	public UsedPostImgDTO(ResultSet rs) throws SQLException {
		this.setPost_img_no(rs.getLong("post_img_no"));
		this.setPost_no(rs.getLong("post_no"));
		this.setPost_img_name(rs.getString("post_img_name"));
		this.setPost_img_type(rs.getString("post_img_type"));
		this.setPost_img_size(rs.getLong("post_img_size"));
	}
	public long getPost_no() {
		return post_no;
	}
	public void setPost_no(long post_no) {
		this.post_no = post_no;
	}
	public long getPost_img_no() {
		return post_img_no;
	}
	public void setPost_img_no(long post_img_no) {
		this.post_img_no = post_img_no;
	}
	public String getPost_img_name() {
		return post_img_name;
	}
	public void setPost_img_name(String post_img_name) {
		this.post_img_name = post_img_name;
	}
	public long getPost_img_size() {
		return post_img_size;
	}
	public void setPost_img_size(long post_img_size) {
		this.post_img_size = post_img_size;
	}
	public String getPost_img_type() {
		return post_img_type;
	}
	public void setPost_img_type(String post_img_type) {
		this.post_img_type = post_img_type;
	}
	public UsedPostImgDTO() {
		super();
	}
	
	
}
