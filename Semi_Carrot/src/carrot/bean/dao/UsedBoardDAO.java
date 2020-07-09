package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import carrot.bean.dto.UsedBoardDTO;

public class UsedBoardDAO {
	
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
	public UsedBoardDTO get(long used_cate_num)throws Exception{
		Connection con = getConnection();
		
		String sql="Select*from used_board where used_cate_num=?";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setLong(1, used_cate_num);
		ResultSet rs=ps.executeQuery();
		
		UsedBoardDTO ubdto = rs.next() ? new UsedBoardDTO(rs) : null;
		
		con.close();
		
		return ubdto;
	}
}
