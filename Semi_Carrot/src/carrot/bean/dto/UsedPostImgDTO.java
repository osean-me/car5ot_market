package carrot.bean.dto;

public class UsedPostImgDTO {
	private long post_img_no;
	private long post_no;
	private String post_img_name;
	private long post_img_size;
	private String post_img_type;
	
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
