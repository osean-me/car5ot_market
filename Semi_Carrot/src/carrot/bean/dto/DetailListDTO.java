package carrot.bean.dto;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DetailListDTO {
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
	private String addr_state;
	private String addr_city;
	private String addr_base;
	
	public DetailListDTO() {
		super();
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
	public long getMember_img_no() {
		return member_img_no;
	}
	public void setMember_img_no(long member_img_no) {
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
	
	public String getPost_time() { //시간
//		String today="오늘";
		return post_date.substring(11, 16);
//		return today;
	}
	
	public String getPost_day() { //날짜
		return post_date.substring(0, 10);
	}
	
	public String getPost_autotime() {

		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if(!(getPost_date().equals(today))) {//오늘 작성한 글이라면
			return getPost_day();
		}
		else {//아니라면
			return getPost_time();
		}
	}
	
	
	public DetailListDTO(ResultSet rs) throws SQLException{
	      this.setPost_no(rs.getLong("post_no"));
	      this.setPost_title(rs.getString("post_title"));
	      this.setPost_content(rs.getString("post_content"));
	      this.setPost_price(rs.getLong("post_price"));
	      this.setPost_date(rs.getString("post_date"));
	      this.setPost_view(rs.getLong("post_view"));
	      this.setPost_like(rs.getLong("post_like"));
	      this.setUsed_cate_num(rs.getLong("used_cate_num"));
	      this.setMember_no(rs.getLong("member_no"));
	      //this.setMember_img_no(rs.getLong("member_img_no"));
	      this.setAddr_no(rs.getLong("addr_no"));
	     // this.setPost_img_no(rs.getLong("post_img_no"));
	      this.setPost_state(rs.getString("post_state"));
	      this.setAddr_state(rs.getString("addr_state"));
		  this.setAddr_city(rs.getString("addr_city"));
		  this.setAddr_base(rs.getString("addr_base"));
	   }
}
