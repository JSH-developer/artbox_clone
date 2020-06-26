
package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.ProductBean;
import vo.QuestionBean;

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
		String sql = "select * from count where category_code like ? order by num desc";
		ProductBean productBean = null;
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		try {
			pstmt = con.prepareStatement(sql);
		
			pstmt.setString(1, majorCategory+"%");
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
				productBean.setProduct_cnt_order(rs.getString("cnt_order"));
				productBean.setProduct_cnt_review(rs.getString("cnt_review"));
				listProduct.add(productBean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		System.out.println(listProduct);
		return 	listProduct;
		
	}	
	
	
	
	public ArrayList<ProductBean> selectMinorLink(String minorCategory) {
		String sql = "select * from count where category_code=? order by num desc";
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
				productBean.setProduct_cnt_order(rs.getString("cnt_order"));
				productBean.setProduct_cnt_review(rs.getString("cnt_review"));
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

	public int insertQuestion(QuestionBean questionBean) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			int num = 1;
			
			String sql = "SELECT MAX(num) FROM question";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			} 
			
			sql = "INSERT INTO question(num,email,field,title,content,member_id,product_num) VALUES (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산된 새 글 번호 사용
			pstmt.setString(2, questionBean.getQuestion_email());
			pstmt.setString(3, questionBean.getQuestion_field());
			pstmt.setString(4, questionBean.getQuestion_title());
			pstmt.setString(5, questionBean.getQuestion_content());
			pstmt.setString(6, questionBean.getQuestion_member_id());
			pstmt.setInt(7, questionBean.getQuestion_product_num());
			
			// INSERT 구문 실행 후 리턴되는 결과값을 insertCount 변수에 저장
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("ItemDAO - insertQuestion() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}


	public ArrayList<ProductBean> search(String kwd) {
		String sql = "select * from count where keywords like ? "
				+ "or name like ? "
				+ "or brand like ? "
				+ "order by num desc";
		ProductBean productBean = null;
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+kwd+"%");
			pstmt.setString(2, "%"+kwd+"%");
			pstmt.setString(3, "%"+kwd+"%");
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
				productBean.setProduct_cnt_order(rs.getString("cnt_order"));
				productBean.setProduct_cnt_review(rs.getString("cnt_review"));
				listProduct.add(productBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
			close(con);
		}
		
		return listProduct;
	}	

}
