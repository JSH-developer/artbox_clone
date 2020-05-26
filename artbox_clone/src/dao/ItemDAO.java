package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.ProductBean;

public class ItemDAO {
	
	private ItemDAO() {}
	
	private static ItemDAO instance;
	
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
	
//----------------------------------------------------------------------------------------------
	
	public ProductBean selectArticle(int product_num) {
		ProductBean article = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		// 게시물 번호(board_num)에 해당하는 게시물 상세 내용 조회 후 BoardBean 객체에 저장
		try {
			String sql = "SELECT * FROM product WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			
			// 게시물이 존재할 경우 BoardBean 객체에 모든 데이터 저장
			if(rs.next()) {
				article = new ProductBean();
				article.setProduct_num(rs.getInt("num"));
				article.setProduct_code(rs.getString("code"));
				article.setProduct_name(rs.getString("name"));
				article.setProduct_image(rs.getString("image"));
				article.setProduct_description(rs.getString("description"));
				article.setProduct_price(rs.getInt("board_price"));
				article.setProduct_brand(rs.getString("board_brand"));
				article.setProduct_stock_count(rs.getInt("board_stock_count"));
				article.setProduct_sale_price(rs.getInt("board_sale_price"));
				article.setProduct_regdate(rs.getTimestamp("board_regdate"));
//				article.setProduct_category_num(rs.getInt("board_category_code"));
//				article.setProduct_option_num(rs.getInt("board_option_code"));
			}
			
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectArticle() 실패 : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return article;
	}	

}
