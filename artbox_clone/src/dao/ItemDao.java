package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import static db.jdbcUtil.*;

import vo.ProductBean;

public class ItemDao {
	private static ItemDao dao;
	private Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	
	private ItemDao() {}
	
	public static ItemDao getDao() {
		if(dao==null) {
			dao = new ItemDao();
		}
		return dao;
	}
	
	public void setCon(Connection con) {
		this.con = con;
	}

	
	
	public ProductBean selectItemDetail() {
		ProductBean productBean = new ProductBean();
		String sql="";
		try {
			pstmt = con.prepareStatement(sql);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return productBean;
		
	}
	

}
