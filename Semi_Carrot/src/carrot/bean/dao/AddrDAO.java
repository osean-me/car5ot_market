package carrot.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import carrot.bean.dto.AddrDTO;

public class AddrDAO {

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

	public Connection getConnection() throws Exception {
		return src.getConnection();
	}

	// [1] 주소 고유 번호 발급
	public long getAddrNo() throws Exception {
		Connection con = getConnection();

		String sql = "SELECT ADDR_SEQ.NEXTVAL FROM DUAL";

		PreparedStatement ps = con.prepareStatement(sql);

		ResultSet rs = ps.executeQuery();

		rs.next();

		long addr_no = rs.getLong(1);

		con.close();

		return addr_no;
	}

	// [2] 주소 입력
	public void insertAddr(AddrDTO adto) throws Exception {
		Connection con = getConnection();

		String sql = "INSERT INTO ADDRESS VALUES(? , ? , ? , ?)";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setLong(1, adto.getAddr_no());
		ps.setString(2, adto.getAddr_state());
		ps.setString(3, adto.getAddr_city());
		ps.setString(4, adto.getAddr_base());

		ps.execute();

		con.close();
	}

	// [3] 동으로 주소 고유 번호 조회
	public Long findAddrNo(String addr_base) throws Exception {
		Connection con = getConnection();

		String sql = "SELECT ADDR_NO FROM ADDRESS WHERE ADDR_BASE = ?";

		PreparedStatement ps = con.prepareStatement(sql);

		ps.setString(1, addr_base);

		ResultSet rs = ps.executeQuery();

		Long addr_no;

		if (rs.next()) {
			addr_no = rs.getLong(1);
		} else {
			addr_no = null;
		}

		con.close();

		return addr_no;
	}
}
