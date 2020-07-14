package carrot.bean.dto;

import java.sql.ResultSet;

public class ReplyDTO {
	private long reply_no;
	private long member_no;
	private long post_no;
	private String reply_content;
	private long super_no;
	private long group_no;
	private long depth;
	private String reply_date;

	public ReplyDTO() {
		super();
	}

	public ReplyDTO(ResultSet rs) throws Exception {
		this.setReply_no(rs.getLong("reply_no"));
		this.setMember_no(rs.getLong("member_no"));
		this.setPost_no(rs.getLong("post_no"));
		this.setReply_content(rs.getString("reply_content"));
		this.setSuper_no(rs.getLong("super_no"));
		this.setGroup_no(rs.getLong("group_no"));
		this.setDepth(rs.getLong("depth"));
		this.setReply_date(rs.getNString("reply_date"));
	}

	public String getReply_date() {
		return reply_date;
	}

	public void setReply_date(String reply_date) {
		this.reply_date = reply_date;
	}

	public long getReply_no() {
		return reply_no;
	}

	public void setReply_no(long reply_no) {
		this.reply_no = reply_no;
	}

	public long getMember_no() {
		return member_no;
	}

	public void setMember_no(long member_no) {
		this.member_no = member_no;
	}

	public long getPost_no() {
		return post_no;
	}

	public void setPost_no(long post_no) {
		this.post_no = post_no;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public long getSuper_no() {
		return super_no;
	}

	public void setSuper_no(long super_no) {
		this.super_no = super_no;
	}

	public long getGroup_no() {
		return group_no;
	}

	public void setGroup_no(long group_no) {
		this.group_no = group_no;
	}

	public long getDepth() {
		return depth;
	}

	public void setDepth(long depth) {
		this.depth = depth;
	}

}
