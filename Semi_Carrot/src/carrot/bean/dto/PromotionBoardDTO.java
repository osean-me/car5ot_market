package carrot.bean.dto;

public class PromotionBoardDTO {
	private long promotion_cate_num;
	private String promotion_cate_title;
	private long  board_no;
	public PromotionBoardDTO() {
		super();
	}
	public long getPromotion_cate_num() {
		return promotion_cate_num;
	}
	public void setPromotion_cate_num(long promotion_cate_num) {
		this.promotion_cate_num = promotion_cate_num;
	}
	public String getPromotion_cate_title() {
		return promotion_cate_title;
	}
	public void setPromotion_cate_title(String promotion_cate_title) {
		this.promotion_cate_title = promotion_cate_title;
	}
	public long getBoard_no() {
		return board_no;
	}
	public void setBoard_no(long board_no) {
		this.board_no = board_no;
	}

}
