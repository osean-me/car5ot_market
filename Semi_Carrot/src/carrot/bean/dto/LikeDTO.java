package carrot.bean.dto;

import java.sql.ResultSet;

public class LikeDTO {
	private long member_no;
	private long board_no;
	private long post_no;

	public LikeDTO() {
		super();
	}
	
	public LikeDTO(ResultSet rs) throws Exception {
		this.setMember_no(rs.getLong("member_no"));
		this.setBoard_no(rs.getLong("board_no"));
		this.setPost_no(rs.getLong("post_no"));
	}

	public long getMember_no() {
		return member_no;
	}

	public void setMember_no(long member_no) {
		this.member_no = member_no;
	}

	public long getBoard_no() {
		return board_no;
	}

	public void setBoard_no(long board_no) {
		this.board_no = board_no;
	}

	public long getPost_no() {
		return post_no;
	}

	public void setPost_no(long post_no) {
		this.post_no = post_no;
	}

}
