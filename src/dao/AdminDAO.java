package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.CategoryBean;
import vo.MemberBean;
import vo.OptionBean;
import vo.OrdersBean;
import vo.OrdersDetailBean;
import vo.ProductBean;
import vo.ReceiverBean;

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
			// 끝에 두글자가 00이면 옵션테이블에 옵션코드 넣기
			// 외래키에 의한 참조무결성 때문에... 
			String sql = "";
			
			if(productBean.getProduct_option_code().substring(3).equals("00")) {
				sql = "INSERT INTO product_option VALUES(null,?,?,0)";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, productBean.getProduct_option_code());
				pstmt.setString(2, productBean.getProduct_option_code().substring(0,3)+"의 기본옵션" );
				
				pstmt.executeUpdate();
			}
			
			
			sql="INSERT INTO product("
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
	
	// 상품 정보를 뽑아서 옵션등록 페이지에서 사용하기
	public ProductBean toViewProduct(String product_code) {
		ProductBean productBean = null;
		
		try {
			String sql="SELECT * FROM product WHERE code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product_code);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				productBean = new ProductBean();
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_brand(rs.getString("brand"));
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
	
	public ArrayList<ProductBean> toListProduct(int page, int limit, String opt, String kwd) {
		ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql = "";
			if(opt.equals("name")) {
				sql="SELECT * FROM product WHERE name LIKE ? ORDER BY num DESC limit ?,?";
			}else if(opt.equals("code")){
				sql="SELECT * FROM product WHERE code LIKE ? ORDER BY num DESC limit ?,?";
			}else if(opt.equals("keywords")){
				sql="SELECT * FROM product WHERE keywords LIKE ? ORDER BY num DESC limit ?,?";
			}
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+kwd+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			
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
	
	public int productCount(String opt, String kwd) {
		int listCount = 0;
		
		try {
			String sql = "";
			if(opt.equals("name")) {
				sql ="SELECT COUNT(num) FROM product WHERE name LIKE ?";
			}else if(opt.equals("code")){
				sql ="SELECT COUNT(num) FROM product WHERE code LIKE ?";
			}else if(opt.equals("keywords")){
				sql ="SELECT COUNT(num) FROM product WHERE keywords LIKE ?";
			}
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,"%"+kwd+"%");
			
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
	
	// 상품 갯수 세기 - 옵션 코드 부여용
	public String productCount2() {
		String listCount = "";
		
		try {
			String sql ="SELECT LPAD(COUNT(num)+1,3,'0') FROM product";
			pstmt=con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				listCount = rs.getString(1);
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
			String sql="SELECT * FROM category WHERE category_code NOT LIKE 'XX%' ORDER BY category_code DESC limit ?,?";
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
	
	// 카테고리 삭제 기능 수행
	public int deleteCategory(int num){
		int deleteCount = 0;
		
		try {
			String sql="UPDATE category SET category_code='XX"+num+"' WHERE num=?";
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
	public String toMakeOptionCode(String product_code_base) {
		String result ="";
		String opt_base = product_code_base.substring(4);
		
		try {
			String sql = "SELECT LPAD(COUNT(num),2,'0') 'option_num' FROM product_option WHERE option_code LIKE ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, opt_base+"%");
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result = opt_base + rs.getString("option_num");
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
			String sql="SELECT * FROM product_option WHERE option_code NOT LIKE '%XX' ORDER BY option_code DESC limit ?,?";
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
	
	// 옵션 기능 삭제 수행
	public int deleteOption(String option_code) {
		int deleteCount = 0;
		try {
//			String sql="DELETE FROM product_option WHERE num=?";
			String sql="UPDATE product_option SET option_code = concat(option_code,'XX') WHERE option_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, option_code);
			
			deleteCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return deleteCount;
	}

	// 상품등록 페이지에서 카테고리의 리스트를 출력하기 위한 함수
	public String toMakeCategorySelect() {
		String result ="";
		
		try {
			String sql="SELECT * FROM category WHERE category_code <> 'XX' ORDER BY category_code DESC";
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
			String sql="SELECT * FROM product_option WHERE option_code NOT LIKE '%00' AND option_code NOT LIKE '%XX'  ORDER BY option_code DESC ";
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
			String sql="SELECT CONCAT(category_code,LEFT(option_code,3)) 'num2', name, code FROM product WHERE code LIKE '%00'";
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
//			String sql="UPDATE product SET code=?, name=?, image=?, image2=?, description=?, price=?, brand=?, stock_count=?, sale_price=?, keywords=?, category_code=?, option_code=? WHERE num=?";
			String sql="UPDATE product SET code=?, name=?, image=?, image2=?, description=?, price=?, brand=?, stock_count=?, sale_price=?, keywords=?, category_code=? WHERE num=?";
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
//			pstmt.setString(12, productBean.getProduct_option_code());
			pstmt.setInt(12, productBean.getProduct_num());
			
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

	
	// 멤버 갯수 세기
	public int memberCount() {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM member";
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
	
	public int memberCount(String opt, String kwd) {
		int listCount = 0;
		
		try {
			String sql = "";
			if(opt.equals("id")) {
				sql ="SELECT COUNT(num) FROM member WHERE id LIKE ?";
			}else if(opt.equals("name")){
				sql ="SELECT COUNT(num) FROM member WHERE name LIKE ?";
			}
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+kwd+"%");
			
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

	
	// 멤버 리스트를 출력하기 위한 함수
	public ArrayList<MemberBean> toListMember(int page, int limit) {
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql="SELECT * FROM member ORDER BY num DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean memberBean = new MemberBean();
				memberBean.setNum(rs.getInt("num"));
				memberBean.setId(rs.getString("id"));
				memberBean.setPw(rs.getString("pw"));
				memberBean.setName(rs.getString("name"));
				memberBean.setPostcode(rs.getString("postcode"));
				memberBean.setAddr_basic(rs.getString("addr_basic"));
				memberBean.setAddr_detail(rs.getString("addr_detail"));
				memberBean.setEmail(rs.getString("email"));
				memberBean.setPhone(rs.getString("phone"));
				memberBean.setGender(rs.getString("gender"));
				memberBean.setPoint(rs.getInt("point"));
				memberBean.setBirth(rs.getString("birth"));
				memberBean.setGrade(rs.getString("grade"));
				memberBean.setRegdate(rs.getDate("regdate"));
				
				memberList.add(memberBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return memberList;
	}
	
	public ArrayList<MemberBean> toListMember(int page, int limit, String opt, String kwd) {
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql = "";
			if(opt.equals("id")) {
				sql ="SELECT * FROM member WHERE id LIKE ? ORDER BY num DESC limit ?,?";
			}else if(opt.equals("name")){
				sql ="SELECT * FROM member WHERE name LIKE ? ORDER BY num DESC limit ?,?";
			}
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+kwd+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean memberBean = new MemberBean();
				memberBean.setNum(rs.getInt("num"));
				memberBean.setId(rs.getString("id"));
				memberBean.setPw(rs.getString("pw"));
				memberBean.setName(rs.getString("name"));
				memberBean.setPostcode(rs.getString("postcode"));
				memberBean.setAddr_basic(rs.getString("addr_basic"));
				memberBean.setAddr_detail(rs.getString("addr_detail"));
				memberBean.setEmail(rs.getString("email"));
				memberBean.setPhone(rs.getString("phone"));
				memberBean.setGender(rs.getString("gender"));
				memberBean.setPoint(rs.getInt("point"));
				memberBean.setBirth(rs.getString("birth"));
				memberBean.setGrade(rs.getString("grade"));
				memberBean.setRegdate(rs.getDate("regdate"));
				
				memberList.add(memberBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return memberList;
	}

	// 멤버 디테일 페이지 구성
	public MemberBean toViewMember(int num) {
		MemberBean memberBean = null;
		
		try {
			String sql="SELECT * FROM member WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				memberBean = new MemberBean();
				memberBean.setNum(rs.getInt("num"));
				memberBean.setId(rs.getString("id"));
				memberBean.setPw(rs.getString("pw"));
				memberBean.setName(rs.getString("name"));
				memberBean.setPostcode(rs.getString("postcode"));
				memberBean.setAddr_basic(rs.getString("addr_basic"));
				memberBean.setAddr_detail(rs.getString("addr_detail"));
				memberBean.setEmail(rs.getString("email"));
				memberBean.setPhone(rs.getString("phone"));
				memberBean.setGender(rs.getString("gender"));
				memberBean.setPoint(rs.getInt("point"));
				memberBean.setBirth(rs.getString("birth"));
				memberBean.setGrade(rs.getString("grade"));
				memberBean.setStatus(rs.getInt("status"));
				memberBean.setRegdate(rs.getDate("regdate"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return memberBean;
	}

	// 멤버 삭제를 위한 함수
	public int deleteMember(int num) {
		int deleteCount = 0;
		
		try {
			String sql="DELETE FROM member WHERE num=?";
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

	// orders 갯수 세기
	public int orderCount() {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM orders";
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
	
	public int orderCount(int state) {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM orders WHERE state=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, state);
			
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

	// order 리스트 만들기
	public ArrayList<OrdersBean> toListOrder(int page, int limit) {
		ArrayList<OrdersBean> orderList = new ArrayList<OrdersBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql="SELECT * FROM orders ORDER BY regdate DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersBean ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getInt("order_num"));
				ordersBean.setOrders_member_id(rs.getString("member_id"));
				ordersBean.setOrders_regdate(rs.getTimestamp("regdate"));
				ordersBean.setOrders_state(rs.getInt("state"));
				orderList.add(ordersBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return orderList;
	}
	
	public ArrayList<OrdersBean> toListOrder(int page, int limit, int state) {
		ArrayList<OrdersBean> orderList = new ArrayList<OrdersBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql="SELECT * FROM orders WHERE state = ? ORDER BY regdate DESC limit ?,?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersBean ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getInt("order_num"));
				ordersBean.setOrders_member_id(rs.getString("member_id"));
				ordersBean.setOrders_regdate(rs.getTimestamp("regdate"));
				ordersBean.setOrders_state(rs.getInt("state"));
				orderList.add(ordersBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return orderList;
	}

	// orders 상세 페이지를 보기위해서 정보 빼오기
	public OrdersBean toViewOrders(int orders_num) {
		OrdersBean ordersBean = null;
		
		try {
			String sql="SELECT * FROM orders WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getInt("order_num"));
				ordersBean.setOrders_member_id(rs.getString("member_id"));
				ordersBean.setOrders_order_name(rs.getString("order_name"));
				ordersBean.setOrders_order_email(rs.getString("order_email"));
				ordersBean.setOrders_order_phone(rs.getString("order_phone"));
				ordersBean.setOrders_point(rs.getInt("point"));
				ordersBean.setOrders_total_price(rs.getInt("total_price"));
				ordersBean.setOrders_payMethod(rs.getString("pay_method"));
				ordersBean.setOrders_state(rs.getInt("state"));
				ordersBean.setOrders_regdate(rs.getTimestamp("regdate"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return ordersBean;
	}

	// reciever 상세정보를 빼오기
	public ReceiverBean toViewReceiver(int orders_order_num) {
		ReceiverBean receiverBean = null;
		
		try {
			String sql="SELECT * FROM receiver WHERE orders_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orders_order_num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				receiverBean = new ReceiverBean();
				receiverBean.setReceiver_num(rs.getInt("num"));
				receiverBean.setReceiver_name(rs.getString("receiver_name"));
				receiverBean.setReceiver_phone(rs.getString("receiver_phone"));
				receiverBean.setReceiver_postcode(rs.getString("receiver_postcode"));
				receiverBean.setReceiver_addr(rs.getString("receiver_addr"));
				receiverBean.setReceiver_addr_detail(rs.getString("receiver_addr_detail"));
//				receiverBean.setReceiver_msg(rs.getString("receiver_msg"));
				receiverBean.setReceiver_date(rs.getTimestamp("receiver_date").toString());
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return receiverBean;
	}

	// 주문상품상세 출력해오기
	public ArrayList<OrdersDetailBean> toViewOrdersDetail(int orders_order_num) {
		ArrayList<OrdersDetailBean> ordersDetailBeans = new ArrayList<OrdersDetailBean>();
		
		try {
			String sql="SELECT * FROM orders_detail WHERE orders_order_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orders_order_num);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDetailBean ordersDetailBean = new OrdersDetailBean();
				ordersDetailBean.setOrdersDetail_num(rs.getInt("num"));
				ordersDetailBean.setOrdersDetail_quantity(rs.getInt("quantity"));
				ordersDetailBean.setOrdersDetail_orders_order_num(rs.getInt("orders_order_num"));
				ordersDetailBean.setOrdersDetail_product_num(rs.getInt("product_num"));
				ordersDetailBean.setOrdersDetail_receiver_num(rs.getInt("receiver_num"));
				ordersDetailBean.setOrdersDetail_code(rs.getString("code"));
				ordersDetailBean.setOrdersDetail_name(rs.getString("name"));
				ordersDetailBean.setOrdersDetail_image(rs.getString("image"));
				ordersDetailBean.setOrdersDetail_price(rs.getInt("price"));
				ordersDetailBeans.add(ordersDetailBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return ordersDetailBeans;
	}

	// 주문 배송상태 변경하기
	public int changeState(int state, int num) {
		int changeCount = 0;
		
		try {
			String sql="UPDATE orders SET state = ? WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, state);
			pstmt.setInt(2, num);
			
			changeCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return changeCount;
	}

}
