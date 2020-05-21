package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ProductBean;

import static db.jdbcUtil.*;

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
	public int regProduct(ProductBean productBean) {
		int insertCount = 0;
		
		try {
			String sql="INSERT INTO product VALUES(null,?,?,?,?,?,?,?,?,null,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, productBean.getProduct_code());
			pstmt.setString(2, productBean.getProduct_name());
			pstmt.setString(3, productBean.getProduct_image());
			pstmt.setString(4, productBean.getProduct_description());
			pstmt.setInt(5, productBean.getProduct_price());
			pstmt.setString(6, productBean.getProduct_brand());
			pstmt.setInt(7, productBean.getProduct_stock_count());
			pstmt.setInt(8, productBean.getProduct_sale_price());
			pstmt.setString(9, "FS01"); //카테고리 임시 삽입
			pstmt.setString(10, "123"); //옵션 임시 삽입
			
			insertCount = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		
		return insertCount;
	}
	
	// 상품 정보를 보기위해, 상품 하나의 정보를 ProductBean에 담아서 반환하는 함수
	public ProductBean toViewProduct(int product_num) {
		ProductBean productBean = null;
		
		try {
			String sql="SELECT * FROM product WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_description(rs.getString("description"));
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_brand(rs.getString("brand"));
				productBean.setProduct_stock_count(rs.getInt("stock_count"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
				productBean.setProduct_category_code(rs.getString("category_code"));
				productBean.setProduct_option_code(rs.getString("option_code"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return productBean;
	}
	
	// 상품 리스트를 출력하기 위한 함수
	public ArrayList<ProductBean> toListProduct(int page, int limit) {
		ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql="SELECT * FROM product ORDER BY num DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ProductBean productBean = new ProductBean();
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_description(rs.getString("description"));
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_brand(rs.getString("brand"));
				productBean.setProduct_stock_count(rs.getInt("stock_count"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
				productBean.setProduct_category_code(rs.getString("category_code"));
				productBean.setProduct_option_code(rs.getString("option_code"));
				productList.add(productBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return productList;
	}
	
	// 상품 갯수 세기
	public int productCount() {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM product";
			pstmt=con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}

}
