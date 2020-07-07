package carrot.bean.dto;

public class CommunityBoardDTO {
	private long community_cate_num;
	private String community_cate_title;
	private long board_no;
	public CommunityBoardDTO() {
		super();
	}
	public long getCommunity_cate_num() {
		return community_cate_num;
	}
	public void setCommunity_cate_num(long community_cate_num) {
		this.community_cate_num = community_cate_num;
	}
	public String getCommunity_cate_title() {
		return community_cate_title;
	}
	public void setCommunity_cate_title(String community_cate_title) {
		this.community_cate_title = community_cate_title;
	}
	public long getBoard_no() {
		return board_no;
	}
	public void setBoard_no(long board_no) {
		this.board_no = board_no;
	}
}
	
