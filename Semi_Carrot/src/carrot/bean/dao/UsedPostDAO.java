package carrot.bean.dao;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UsedPostDAO {
	private static DataSource src;

	static {
		try {
			Context ctx = new InitialContext();
			Context env = (Context) ctx.lookup("java:/comp/env");
			src = (DataSource) env.lookup("jdbc.oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() throws Exception {
		return src.getConnection();
	}
	

	
	
}
