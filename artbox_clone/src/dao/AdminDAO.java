package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.CategoryBean;
import vo.OptionBean;
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
			String sql="INSERT INTO product("
					+ "code,name,image,image2,description,price,brand,stock_count,"
					+ "sale_price,keywords,category_code,option_code) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, productBean.getProduct_code());
			pstmt.setString(2, productBean.getProduct_name());
			pstmt.setString(3, productBean.getProduct_image());
			pstmt.setString(4, productBean.getProduct_image2());
			pstmt.setString(5, productBean.getProduct_description());
			pstmt.setInt(6, productBean.getProduct_price());
			pstmt.setString(7, productBean.getProduct_brand());
			pstmt.setInt(8, productBean.getProduct_stock_count());
			pstmt.setInt(9, productBean.getProduct_sale_price());
			pstmt.setString(10, productBean.getProduct_keywords());
			pstmt.setString(11, productBean.getProduct_category_code());
			pstmt.setString(12, productBean.getProduct_option_code());
			
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
				productBean.setProduct_keywords(rs.getString("keywords"));
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
	
	// 카테고리 등록
	public int regCategory(CategoryBean categoryBean) {
		int insertCount = 0;
		
		try {
			//
			String sql="INSERT INTO category VALUES (null, (SELECT code FROM ( SELECT concat(?, LPAD(IFNULL(COUNT(num)+1,0),'2','0')) 'code' FROM category WHERE category_sup=? ) as ctemp), ?, ?)"; 
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, categoryBean.getCategory_sup());
			pstmt.setString(2, categoryBean.getCategory_sup());
			pstmt.setString(3, categoryBean.getCategory_sup());
			pstmt.setString(4, categoryBean.getCategory_sub());
			
			insertCount = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		
		return insertCount;
		
	}
	
	// 카테고리 리스트를 출력하기 위한 함수
	public ArrayList<CategoryBean> toListCategory(int page, int limit) {
		ArrayList<CategoryBean> categoryList = new ArrayList<CategoryBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql="SELECT * FROM category ORDER BY category_sup DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				CategoryBean categoryBean = new CategoryBean();
				categoryBean.setCategory_num(rs.getInt("num"));
				categoryBean.setCategory_code(rs.getString("category_code"));
				categoryBean.setCategory_sup(rs.getString("category_sup"));
				categoryBean.setCategory_sub(rs.getString("category_sub"));
				categoryList.add(categoryBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return categoryList;
	}
	
	// 카테고리 갯수 세기
	public int categoryCount() {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM category";
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

	// 옵션을 등록하기 위한 함수
	public int regOption(OptionBean optionBean) {
		int insertCount=0;
		
		try {
			String sql = "INSERT INTO product_option VALUES(null,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, optionBean.getOption_code());
			pstmt.setString(2, optionBean.getOption_name());
			pstmt.setInt(3, optionBean.getAdd_price());
			
			insertCount = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return insertCount;
	}

	// 옵션코드를 만들기 위한 함수
	public String toMakeOptionCode(String product_index) {
		String result ="";
		
		try {
			String sql = "SELECT LPAD(MAX(num)+1,2,'0') 'product_num' FROM product_option";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result = product_index + rs.getString("product_num");
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}
	
	// 옵션 리스트를 출력하기 위한 함수
	public ArrayList<OptionBean> toListOption(int page, int limit) {
		ArrayList<OptionBean> optionList = new ArrayList<OptionBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql="SELECT * FROM product_option ORDER BY option_code DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				OptionBean optionBean = new OptionBean();
				optionBean.setOption_num(rs.getInt("num"));
				optionBean.setOption_code(rs.getString("option_code"));
				optionBean.setOption_name(rs.getString("option_name"));
				optionBean.setAdd_price(rs.getInt("add_price"));
				optionList.add(optionBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return optionList;
	}
	
	// 옵션 갯수 세기
	public int optionCount() {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM product_option";
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

	// 상품등록 페이지에서 카테고리의 리스트를 출력하기 위한 함수
	public String toMakeCategorySelect() {
		String result ="";
		
		try {
			String sql="SELECT * FROM category ORDER BY category_sup DESC";
			pstmt=con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				result += "<option value=\"" + rs.getString("category_code") + "\"> " + rs.getString("category_sup") + " > " + rs.getString("category_sub") + " </option>";
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}

	// 상품등록 페이지에서 옵션의 리스트를 출력하기 위한 함수
	public String toMakeOptionSelect() {
		String result ="";
		
		try {
			String sql="SELECT * FROM product_option ORDER BY option_code DESC";
			pstmt=con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				result += "<option value=\"" + rs.getString("option_code") + "\"> " + rs.getString("option_name") + "(+" + rs.getString("add_price") + ") </option>";
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}
	
	// 옵션등록 페이지에서 상품의 리스트를 출력하기 위한 함수
	public String toMakeProductSelect() {
		String result ="";
		
		try {
			String sql="SELECT LPAD(num,'2','0') 'num2', name, code FROM product";
			pstmt=con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				result += "<option value=\"" + rs.getString("num2") + "\"> " + rs.getString("name") + "(" + rs.getString("code") + ") </option>";
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}

	//  상품 수정 기능 수행
	public int modifyProduct(ProductBean productBean) {
		int updateCount = 0;
		
		try {
			String sql="UPDATE product SET code=?, name=?, image=?, image2=?, description=?, price=?, brand=?, stock_count=?, sale_price=?, keywords=?, category_code=?, option_code=? WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, productBean.getProduct_code());
			pstmt.setString(2, productBean.getProduct_name());
			pstmt.setString(3, productBean.getProduct_image());
			pstmt.setString(4, productBean.getProduct_image2());
			pstmt.setString(5, productBean.getProduct_description());
			pstmt.setInt(6, productBean.getProduct_price());
			pstmt.setString(7, productBean.getProduct_brand());
			pstmt.setInt(8, productBean.getProduct_stock_count());
			pstmt.setInt(9, productBean.getProduct_sale_price());
			pstmt.setString(10, productBean.getProduct_keywords());
			pstmt.setString(11, productBean.getProduct_category_code());
			pstmt.setString(12, productBean.getProduct_option_code());
			pstmt.setInt(13, productBean.getProduct_num());
			
			updateCount = pstmt.executeUpdate();
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return updateCount;
	}

	// 상품 삭제 기능 수행
	public int deleteProduct(int num) {
		int deleteCount = 0;
		
		try {
			String sql="DELETE FROM product WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			deleteCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return deleteCount;
	}

}
