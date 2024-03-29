package carrot.bean.dto;

import java.sql.ResultSet;

public class CommunityPostDTO {

	private int post_no;
	private String post_title;
	private String post_content;
	private String post_date;
	private int post_view;
	private int community_cate_num;
	private long member_no;
	private long member_img_no;
	private long addr_no;
	private long board_no;

	public int getPost_no() {
		return post_no;
	}

	public void setPost_no(int post_no) {
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

	public String getPost_date() {
		return post_date;
	}

	public void setPost_date(String post_date) {
		this.post_date = post_date;
	}

	public int getPost_view() {
		return post_view;
	}

	public void setPost_view(int post_view) {
		this.post_view = post_view;
	}

	public int getCommunity_cate_num() {
		return community_cate_num;
	}

	public void setCommunity_cate_num(int community_cate_num) {
		this.community_cate_num = community_cate_num;
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

	public long getBoard_no() {

		return board_no;
	}

	public void setBoard_no(long board_no) {
		this.board_no = board_no;
	}

	public CommunityPostDTO(ResultSet rs) throws Exception {
		this.setPost_no(rs.getInt("post_no"));
		this.setPost_title(rs.getNString("post_title"));
		this.setPost_content(rs.getNString("post_content"));
		this.setPost_date(rs.getString("post_date"));
		this.setPost_view(rs.getInt("post_view"));
		this.setCommunity_cate_num(rs.getInt("community_cate_num"));
		this.setMember_no(rs.getLong("member_no"));
		this.setMember_img_no(rs.getLong("member_img_no"));
		this.setAddr_no(rs.getLong("addr_no"));
		this.setBoard_no(rs.getLong("board_no"));
	}

}
