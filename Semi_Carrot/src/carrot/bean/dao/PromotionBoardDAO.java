package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import carrot.bean.dto.PromotionBoardDTO;
import carrot.bean.dto.PromotionPostDTO;
import carrot.bean.dto.UsedBoardDTO;

public class PromotionBoardDAO {
	private static DataSource src;
	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc/oracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection() throws Exception{
		return src.getConnection();
	}
	
	//단일조회
	public PromotionBoardDTO get(long promotion_cate_num)throws Exception{
		Connection con = getConnection();
		
		String sql="Select * from promotion_board where promotion_cate_num=?";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setLong(1, promotion_cate_num);
		ResultSet rs=ps.executeQuery();
		
		PromotionBoardDTO pbdto = rs.next() ? new PromotionBoardDTO(rs) : null;
		
		con.close();
		
		return pbdto;
	}
}
