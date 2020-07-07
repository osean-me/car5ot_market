package carrot.bean.dto;

public class BoardDto {
	private long board_no;
	private  String board_title;
	public BoardDto() {
		super();
	}
	public long getBoard_no() {
		return board_no;
	}
	public void setBoard_no(long board_no) {
		this.board_no = board_no;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

}
