
package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ProductBean;

public class ItemDAO {
	
	private ItemDAO() {}
	
	private static ItemDAO instance;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public static ItemDAO getInstance() {
		// ItemDAO 객체가 없을 경우에만 생성
		if(instance == null) {
			instance = new ItemDAO();
		}
		return instance;
	}
	
	private Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	

	public ArrayList<ProductBean> selectMajorLink(String majorCategory) {
		String sql = "select * from product where category_code like '?%'";
		ProductBean productBean = null;
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, majorCategory);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_image2(rs.getString("image2"));
				productBean.setProduct_description(rs.getString("description"));
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_brand(rs.getString("brand"));
				productBean.setProduct_stock_count(rs.getInt("stock_count"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
				productBean.setProduct_keywords(rs.getString("keywords"));
				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
				productBean.setProduct_category_code(rs.getString("category_code"));
				productBean.setProduct_option_code(rs.getString("option_code"));
				listProduct.add(productBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return 	listProduct;
		
	}	
	
	
	
	public ArrayList<ProductBean> selectMinorLink(String minorCategory) {
		String sql = "select * from product where category_code=?";
		ProductBean productBean = null;
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, minorCategory);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_image2(rs.getString("image2"));
				productBean.setProduct_description(rs.getString("description"));
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_brand(rs.getString("brand"));
				productBean.setProduct_stock_count(rs.getInt("stock_count"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
				productBean.setProduct_keywords(rs.getString("keywords"));
				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
				productBean.setProduct_category_code(rs.getString("category_code"));
				productBean.setProduct_option_code(rs.getString("option_code"));
				listProduct.add(productBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		return 	listProduct;
		
	}	

}
