
package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CategoryBean;
import vo.ProductBean;
import vo.QuestionBean;
import vo.ReviewBean;

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
	
	
	public ArrayList<ProductBean> selectOtherOptionList(String product_option_code) {
		ArrayList<ProductBean> otherOptionList = new ArrayList<ProductBean>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String fulloption = product_option_code;
		String option = product_option_code.substring(0, 3)+"__";
		
		try {
			String sql = "SELECT * from product WHERE option_code LIKE ? AND option_code NOT LIKE ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, option);
			pstmt.setString(2, fulloption);	// 3은 구매확정 상태
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean article = new ProductBean();
				article.setProduct_num(rs.getInt("num"));
				article.setProduct_image(rs.getString("image"));
				article.setProduct_name(rs.getString("name"));
				article.setProduct_price(rs.getInt("price"));
				otherOptionList.add(article);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectOtherOptionList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return otherOptionList;
	}
	
	
	public int insertReview(ReviewBean reviewBean) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			int num = 1;
			
			String sql = "SELECT MAX(num) FROM review";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			} 
			sql = "INSERT INTO review(num,skill,design,price,quality,regdate,content,re_check,img1,img2,img3,img4,img5,member_id,product_num) VALUES (?,?,?,?,?,now(),?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산된 새 글 번호 사용
			pstmt.setInt(2, reviewBean.getReview_skill());
			pstmt.setInt(3, reviewBean.getReview_design());
			pstmt.setInt(4, reviewBean.getReview_price());
			pstmt.setInt(5, reviewBean.getReview_quality());
			pstmt.setString(6, reviewBean.getReview_content());
			pstmt.setInt(7, 0);
			pstmt.setString(8, reviewBean.getReview_img1());
			pstmt.setString(9, reviewBean.getReview_img2());
			pstmt.setString(10, reviewBean.getReview_img3());
			pstmt.setString(11, reviewBean.getReview_img4());
			pstmt.setString(12, reviewBean.getReview_img5());
			pstmt.setString(13, reviewBean.getReview_member_id());
			pstmt.setInt(14, reviewBean.getReview_product_num());

			// INSERT 구문 실행 후 리턴되는 결과값을 insertCount 변수에 저장
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("ItemDAO - insertReview() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return insertCount;
	}
	
	
	public int updateReview(ReviewBean reviewBean) {
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {			
			String sql = "UPDATE review "
					+ "SET skill=?, design=?, price=?, quality=?, content=?, img1=?, img2=?, img3=?, img4=?, img5=? "
					+ "WHERE num =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, reviewBean.getReview_skill());
			pstmt.setInt(2, reviewBean.getReview_design());
			pstmt.setInt(3, reviewBean.getReview_price());
			pstmt.setInt(4, reviewBean.getReview_quality());
			pstmt.setString(5, reviewBean.getReview_content());
			pstmt.setString(6, reviewBean.getReview_img1());
			pstmt.setString(7, reviewBean.getReview_img2());
			pstmt.setString(8, reviewBean.getReview_img3());
			pstmt.setString(9, reviewBean.getReview_img4());
			pstmt.setString(10, reviewBean.getReview_img5());
			pstmt.setInt(11, reviewBean.getReview_num());

			// UPDATE 구문 실행 후 리턴되는 결과값을 updateCount 변수에 저장
			updateCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("ItemDAO - updateReview() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return updateCount;
	}

	public int deleteReview(String id, int review_num) {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {			
			String sql = "DELETE FROM review WHERE num=? AND member_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, review_num);
			pstmt.setString(2, id);

			// DELETE 구문 실행 후 리턴되는 결과값을 deleteCount 변수에 저장
			deleteCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("ItemDAO - deleteReview() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return deleteCount;
	}
	

	public int selectItemReviewListCount(String id) {
		int listCount=0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(detail.num) "
					+ "FROM orders INNER JOIN orders_detail detail ON orders.order_num = detail.orders_order_num "
					+ "WHERE orders.member_id = ? AND orders.state = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, 3);	
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectItemReviewListCount() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	public ArrayList<ProductBean> selectItemReviewList(String id, int page, int limit) {
		ArrayList<ProductBean> itemReviewList = new ArrayList<ProductBean>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (page - 1) * limit;
		
		try {
			String sql = "SELECT detail.product_num, detail.image, detail.name, detail.price, DATE_ADD(orders.regdate, INTERVAL 6 MONTH) "
					+ "FROM orders INNER JOIN orders_detail detail ON orders.order_num = detail.orders_order_num "
					+ "WHERE orders.member_id = ? AND orders.state = ? LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, 3);	// 3은 구매확정 상태
			pstmt.setInt(3, startRow);
			pstmt.setInt(4, limit);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean article = new ProductBean();
				article.setProduct_num(rs.getInt("detail.product_num"));
				article.setProduct_image(rs.getString("detail.image"));
				article.setProduct_name(rs.getString("detail.name"));
				article.setProduct_price(rs.getInt("detail.price"));
				article.setProduct_regdate(rs.getTimestamp("DATE_ADD(orders.regdate, INTERVAL 6 MONTH)"));
				itemReviewList.add(article);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectItemReviewList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return itemReviewList;
	}
		

	public int selectItemReviewModListCount(String id) {
		int listCount=0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {String sql = "SELECT COUNT(num) FROM review WHERE member_id=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectItemReviewModListCount() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	
	public ArrayList<ReviewBean> selectItemReviewModList(String id, int page, int limit) {
		ArrayList<ReviewBean> itemReviewModList = new ArrayList<ReviewBean>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (page - 1) * limit;
		
		try {
			String sql = "SELECT * "
					+ "FROM review INNER JOIN product ON review.product_num = product.num "
					+ "WHERE member_id=? LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean article = new ReviewBean();
				article.setReview_num(rs.getInt("review.num"));
				article.setReview_skill(rs.getInt("review.skill"));
				article.setReview_design(rs.getInt("review.design"));
				article.setReview_price(rs.getInt("review.price"));
				article.setReview_quality(rs.getInt("review.quality"));
				article.setReview_regdate(rs.getTimestamp("review.regdate"));
				article.setReview_content(rs.getString("review.content"));
				article.setReview_re_name(rs.getString("product.image"));
				article.setReview_member_id(rs.getString("review.member_id"));
				article.setReview_product_num(rs.getInt("review.product_num"));
				article.setReview_img1(rs.getString("review.img1"));
				article.setReview_img2(rs.getString("review.img2"));
				article.setReview_img3(rs.getString("review.img3"));
				article.setReview_img4(rs.getString("review.img4"));
				article.setReview_img5(rs.getString("review.img5"));
				itemReviewModList.add(article);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectItemReviewModList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return itemReviewModList;
	}
	
	
	public int selecReviewtListCount(int porduct_num) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(num) FROM review WHERE product_num=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, porduct_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selecReviewtListCount() 실패! : " + e.getMessage());
		} finally {
			// DB 자원 반환
			close(rs);
			close(pstmt);
		}
		
		return listCount;
	}
	
	public ArrayList<ReviewBean> selectReviewList(int porduct_num, int page, int limit) {
		ArrayList<ReviewBean> reviewList = new ArrayList<ReviewBean>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (page - 1) * limit;
		
		try {
			String sql = "SELECT * FROM review WHERE product_num=? LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, porduct_num);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean article = new ReviewBean();
				article.setReview_num(rs.getInt("num"));
				article.setReview_skill(rs.getInt("skill"));
				article.setReview_design(rs.getInt("design"));
				article.setReview_price(rs.getInt("price"));
				article.setReview_quality(rs.getInt("quality"));
				article.setReview_regdate(rs.getTimestamp("regdate"));
				article.setReview_content(rs.getString("content"));
				article.setReview_re_check(rs.getInt("re_check"));
				article.setReview_re_name(rs.getString("re_name"));
				article.setReview_re_regdate(rs.getTimestamp("re_regdate"));
				article.setReview_re_content(rs.getString("re_content"));
				article.setReview_member_id(rs.getString("member_id"));
				article.setReview_product_num(rs.getInt("product_num"));
				article.setReview_img1(rs.getString("img1"));
				article.setReview_img2(rs.getString("img2"));
				article.setReview_img3(rs.getString("img3"));
				article.setReview_img4(rs.getString("img4"));
				article.setReview_img5(rs.getString("img5"));
				reviewList.add(article);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectReviewList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return reviewList;
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
			
			sql = "INSERT INTO question(num,email,field,title,content,regdate,member_id,product_num) VALUES (?,?,?,?,?,now(),?,?)";
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


	public ArrayList<QuestionBean> selectQuestionList(int product_num, int q_startRow, int q_pageSize) {
		ArrayList<QuestionBean> questionList = new ArrayList<QuestionBean>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM question WHERE product_num=? ORDER BY num desc LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			pstmt.setInt(2, q_startRow);
			pstmt.setInt(3, q_pageSize);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				QuestionBean article = new QuestionBean();
				article.setQuestion_title(rs.getString("title"));
				article.setQuestion_content(rs.getString("content"));
				article.setQuestion_answer(rs.getString("answer"));
				article.setQuestion_member_id(rs.getString("member_id"));
				article.setQuestion_regdate(rs.getTimestamp("regdate"));
				questionList.add(article);
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - selectQuestionList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return questionList;
	}


	public int getQuestionCount(int product_num) {
		int count = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT count(num) FROM question WHERE product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count(num)");
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - getQuestionCount() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}


	public CategoryBean getCategory(String product_category_code) {
		System.out.println("getCategory");
		CategoryBean categoryBean = new CategoryBean();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM category WHERE category_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product_category_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				categoryBean.setCategory_code(rs.getString("category_code"));
				categoryBean.setCategory_sup(rs.getString("category_sup"));
				categoryBean.setCategory_sub(rs.getString("category_sub"));
			}
		} catch (SQLException e) {
			System.out.println("ItemDAO - getCategory() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		System.out.println(categoryBean.getCategory_sub());
		return categoryBean;
	}


}
