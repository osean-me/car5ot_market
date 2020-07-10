package carrot.bean.dto;

public class PromotionPostDTO {
   private long post_no;
   private String post_title;
   private String post_content;
   private long post_price;
   private String post_date;
   private String post_phone;
   private long post_view;
   private long post_like;
   private long promotion_cate_num;
   private long member_no;
   private long member_img_no;
   private long addr_no;
   
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
   public String getPost_phone() {
      return post_phone;
   }
   public void setPost_phone(String post_phone) {
      this.post_phone = post_phone;
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
   public long getPromotion_cate_num() {
      return promotion_cate_num;
   }
   public void setPromotion_cate_num(long promotion_cate_num) {
      this.promotion_cate_num = promotion_cate_num;
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
   public PromotionPostDTO() {
      super();
   }
   
}