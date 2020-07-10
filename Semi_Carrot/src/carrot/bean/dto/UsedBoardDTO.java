package carrot.bean.dto;

import java.sql.ResultSet;
import java.sql.SQLException;

public class UsedBoardDTO {
	private long used_cate_num;
	private String used_cate_title;
	private long board_no;
	
	public UsedBoardDTO(ResultSet rs)throws SQLException{
		this.setUsed_cate_num(rs.getLong("used_cate_num"));
		this.setUsed_cate_title(rs.getString("used_cate_title"));
		this.setBoard_no(rs.getLong("board_no"));
	}
	public UsedBoardDTO() {
		super();
	}
	public long getUsed_cate_num() {
		return used_cate_num;
	}
	public void setUsed_cate_num(long used_cate_num) {
		this.used_cate_num = used_cate_num;
	}
	public String getUsed_cate_title() {
		return used_cate_title;
	}
	public void setUsed_cate_title(String used_cate_title) {
		this.used_cate_title = used_cate_title;
	}
	public long getBoard_no() {
		return board_no;
	}
	public void setBoard_no(long board_no) {
		this.board_no = board_no;
	}

}
