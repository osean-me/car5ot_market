package carrot.bean.dto;

public class UsedPostDto {
	private long post_no;
	private String post_title;
	private String post_content;
	private long post_price;
	private String post_date;
	private long post_view;
	private long post_like;
	private long used_cate_num;
	private long member_no;
	private long member_img_no;
	private long addr_no;
	private long post_img_no;
	private String post_state;
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
	public String getPost_content() {
		return post_content;
	}
	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}
	public long getPost_price() {
		return post_price;
	}
	public void setPost_price(long post_price) {
		this.post_price = post_price;
	}
	public String getPost_date() {
		return post_date;
	}
	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}
	public long getPost_view() {
		return post_view;
	}
	public void setPost_view(long post_view) {
		this.post_view = post_view;
	}
	public long getPost_like() {
		return post_like;
	}
	public void setPost_like(long post_like) {
		this.post_like = post_like;
	}
	public long getUsed_cate_num() {
		return used_cate_num;
	}
	public void setUsed_cate_num(long used_cate_num) {
		this.used_cate_num = used_cate_num;
	}
	public long getMember_no() {
		return member_no;
	}
	public void setMember_no(long member_no) {
		this.member_no = member_no;
	}
	public long getmember_img_no() {
		return member_img_no;
	}
	public void setmember_img_no(long member_img_no) {
		this.member_img_no = member_img_no;
	}
	public long getAddr_no() {
		return addr_no;
	}
	public void setAddr_no(long addr_no) {
		this.addr_no = addr_no;
	}
	public long getPost_img_no() {
		return post_img_no;
	}
	public void setPost_img_no(long post_img_no) {
		this.post_img_no = post_img_no;
	}
	public String getPost_state() {
		return post_state;
	}
	public void setPost_state(String post_state) {
		this.post_state = post_state;
	}
	
	public UsedPostDto() {
		super();
	}
}
