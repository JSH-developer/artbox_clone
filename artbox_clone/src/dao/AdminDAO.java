package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.ProductBean;

public class AdminDAO {

//	 싱글톤 패턴 사용
	private AdminDAO() {}
	
	private static AdminDAO instance = new AdminDAO();
	
	public static AdminDAO  getInstance() {
		if(instance == null) {
			instance = new AdminDAO();
		}
		return instance;
	}
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// jdbcUtil을 이용하여 service부분에서 connection할 예정
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	// admin 페이지에서 상품 등록하기 
	public int regProduct(ProductBean pb) {
		System.out.println("regProduct 실행됨");
		int insertCount = 0;
		
		try {
			String sql="INSERT INTO product VALUES(null,?,?,?,?,?,?,?,?,null,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, pb.getProduct_code());
			pstmt.setString(2, pb.getProduct_name());
			pstmt.setString(3, pb.getProduct_image());
			pstmt.setString(4, pb.getProduct_description());
			pstmt.setInt(5, pb.getProduct_price());
			pstmt.setString(6, pb.getProduct_brand());
			pstmt.setInt(7, pb.getProduct_stock_count());
			pstmt.setInt(8, pb.getProduct_sale_price());
			pstmt.setInt(9, 1); //카테고리번호 임시 삽입
			pstmt.setInt(10, 1); //옵션번호 임시 삽입
			
			insertCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		
		return insertCount;
	}
	
	
	

}
