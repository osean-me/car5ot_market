package carrot.bean.dto;

public class PostImgDTO {
	private long post_no;
	private String post_img_name;
	private String post_img;
	private long post_img_size;
	public PostImgDTO() {
		super();
	}
	public long getPost_no() {
		return post_no;
	}
	public void setPost_no(long post_no) {
		this.post_no = post_no;
	}
	public String getPost_img_name() {
		return post_img_name;
	}
	public void setPost_img_name(String post_img_name) {
		this.post_img_name = post_img_name;
	}
	public String getPost_img() {
		return post_img;
	}
	public void setPost_img(String post_img) {
		this.post_img = post_img;
	}
	public long getPost_img_size() {
		return post_img_size;
	}
	public void setPost_img_size(long post_img_size) {
		this.post_img_size = post_img_size;
	}
	
}
