package carrot.bean.dto;

import java.sql.ResultSet;

public class ProfileImgDTO {
   private long member_img_no;
   private long member_no;
   private String member_img_name;
   private String member_img_type;
   private long member_img_size;

   public ProfileImgDTO() {
      super();
   }

   public ProfileImgDTO(ResultSet rs) throws Exception {
      this.setMember_img_no(rs.getLong("MEMBER_IMG_NO"));
      this.setMember_no(rs.getLong("MEMBER_NO"));
      this.setMember_img_name(rs.getString("MEMBER_IMG_NAME"));
      this.setMember_img_type(rs.getString("MEMBER_IMG_TYPE"));
      this.setMember_img_size(rs.getLong("MEMBER_IMG_SIZE"));
   }

   public long getMember_img_no() {
      return member_img_no;
   }

   public void setMember_img_no(long member_img_no) {
      this.member_img_no = member_img_no;
   }

   public long getMember_no() {
      return member_no;
   }

   public void setMember_no(long member_no) {
      this.member_no = member_no;
   }

   public String getMember_img_name() {
      return member_img_name;
   }

   public void setMember_img_name(String member_img_name) {
      this.member_img_name = member_img_name;
   }

   public String getMember_img_type() {
      return member_img_type;
   }

   public void setMember_img_type(String member_img_type) {
      this.member_img_type = member_img_type;
   }

   public long getMember_img_size() {
      return member_img_size;
   }

   public void setMember_img_size(long member_img_size) {
      this.member_img_size = member_img_size;
   }

}