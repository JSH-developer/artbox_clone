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
				sql = "INSERT INTO product_option VALUES(null,?,?,0)"; //기본옵션등록 수행
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, productBean.getProduct_option_code());
				pstmt.setString(2, productBean.getProduct_option_code().substring(0,3)+"의 기본옵션" );
				
				pstmt.executeUpdate();
			}
			
			
			sql="INSERT INTO product("
					+ "code,name,image,image2,description,price,brand,stock_count,"
					+ "sale_price,keywords,category_code,option_code) "
					+ "VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"; // product 테이블에 상품 등록
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
			String sql="SELECT * FROM product WHERE num=?"; //인덱스번호를 참조하여 상품상세 조회
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
	
	// 오버로딩, 상품 정보를 뽑아서 옵션등록 페이지에서 사용하기
	public ProductBean toViewProduct(String product_code) {
		ProductBean productBean = null;
		
		try {
			String sql="SELECT * FROM product WHERE code=?"; // 상품코드를 통해 상품정보 조회
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
		
		int startRow = (page-1)*limit; // 페이지와 출력갯수를 변수로 받아서 limit에 대입한다
		
		try {
			String sql="SELECT * FROM product ORDER BY num DESC limit ?,?"; // 상품 인덱스 역 순으로 출력
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
	
	// 오버로딩 : kwd와 opt변수가 존재할 시(검색기능 사용) 사용하는 상품리스트 출력 함수
	public ArrayList<ProductBean> toListProduct(int page, int limit, String opt, String kwd) {
		ArrayList<ProductBean> productList = new ArrayList<ProductBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql = "";
			if(opt.equals("name")) { // 분류가 상품명 일때
				sql="SELECT * FROM product WHERE name LIKE ? ORDER BY num DESC limit ?,?";
			}else if(opt.equals("code")){ // 분류가 상품코드 일때
				sql="SELECT * FROM product WHERE code LIKE ? ORDER BY num DESC limit ?,?";
			}else if(opt.equals("keywords")){ // 분류가 상품 키워드 일때
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
	
	// 상품 최대 갯수 세기 -> 페이징 처리시 사용되는 함수
	public int productCount() {
		int listCount = 0;
		
		try {
			String sql ="SELECT COUNT(num) FROM product"; // product테이블의 인덱스 수를 계산한다.
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
	
	//검색기능 활용시 상품갯수 세기 -> 페이징처리시 사용
	public int productCount(String opt, String kwd) {
		int listCount = 0;
		
		try {
			String sql = "";
			if(opt.equals("name")) { // 분류가 상품명 일 때
				sql ="SELECT COUNT(num) FROM product WHERE name LIKE ?";
			}else if(opt.equals("code")){ // 분류가 상품코드 일 때
				sql ="SELECT COUNT(num) FROM product WHERE code LIKE ?";
			}else if(opt.equals("keywords")){ // 분류가 상품 키워드 일 때
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
			String sql ="SELECT LPAD(IFNULL(MAX(num),0)+1,3,'0') FROM product";
			// 상품 최대 인덱스에 1을 더하고 총 3자리 숫자로 만드는 구문 ex) 001, 010, 099
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
			// category 테이블에 등록
			String sql="INSERT INTO category VALUES (null, (SELECT code FROM ( SELECT concat(?, LPAD(IFNULL(COUNT(num)+1,0),'2','0')) 'code' FROM category WHERE category_sup=? ) as ctemp), ?, ?)";
			// 같은 대분류명 뒤에 순서대로 소분류 번호가 지정되도록 하는 구문 ex) DT01, DT02, DT03, ...
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
			// 카테고리 삭제시 XX가 맨앞에 붙도록 업데이트 되는데, 그 값을 제외하고 출력한다
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
			// 카테고리 삭제시 카테고리코드 앞에 XX가 붙도록 수정됨
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
			String sql = "INSERT INTO product_option VALUES(null,?,?,?)"; // option 테이블에 등록
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
			// 상품 인덱스 두자리와 옵션번호를 합쳐서 5자리 옵션코드를 만든다 ex)01001, 01002, 01003, 11001
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
			// 옵션삭제시 옵션코드 앞자리에 XX가 붙도록 업데이트 되는데, 그것을 제외하고 출력한다
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
			String sql="UPDATE product_option SET option_code = concat(option_code,'XX') WHERE option_code=?";
			// 옵션사제시 옵션코드 앞자리에 XX가 붙도록 구현
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
			// 상품등록 select박스에 출력하기위한 용도, XX가 붙은것을 제외한 카테고리목록 출력 
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
			// 상품등록 select 박스에서 출력하기 위한 구문, 기본옵션뒤에는 00이 붙는데 그것을 제외하고 출력
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
			//옵션상품 등록시 select 박스에 출력하기 위한 구문,기본옵션 뒤에는 00이 붙는데 00이 포함되는 것만 출력 -> 기본옵션의 상품만 출력
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
			String sql="UPDATE product SET code=?, name=?, image=?, image2=?, description=?, price=?, brand=?, stock_count=?, sale_price=?, keywords=?, category_code=? WHERE num=?";
			// 상품 인덱스를 기준으로 상품 정보 수정
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
			// 상품 인덱스를 기준으로 삭제 수행
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
			// member 테이블의 인덱스 갯수 세기
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
	
	// 오버로딩 : 멤버 갯수 세기, opt와 kwd가 존재할 시 (검색 기능 사용시)
	public int memberCount(String opt, String kwd) {
		int listCount = 0;
		
		try {
			String sql = "";
			if(opt.equals("id")) { // 분류가 회원아이디 일 때
				sql ="SELECT COUNT(num) FROM member WHERE id LIKE ?";
			}else if(opt.equals("name")){ // 분류가 회원이름 일 때
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
				memberBean.setStatus(rs.getInt("status"));
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
	
	// 오버로딩 : 멤버 리스트를 출력하기 위한 함수, opt와 kwd가 존재할 시 (검색기능 사용시)
	public ArrayList<MemberBean> toListMember(int page, int limit, String opt, String kwd) {
		ArrayList<MemberBean> memberList = new ArrayList<MemberBean>();
		
		int startRow = (page-1)*limit;
		
		try {
			String sql = "";
			if(opt.equals("id")) { // 분류가 회원아이디 일 때
				sql ="SELECT * FROM member WHERE id LIKE ? ORDER BY num DESC limit ?,?";
			}else if(opt.equals("name")){ // 분류가 회원이름 일 때
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
			String sql="SELECT * FROM member WHERE num=?"; // member의 index를 기준으로 조회
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
			String sql="DELETE FROM member WHERE num=?"; // member의 인덱스를 기준으로 삭제
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
			String sql ="SELECT COUNT(num) FROM orders"; // orders 테이블의 인덱스 갯수 세기
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
	
	// 오버로딩 : orders 갯수 세기, state가 존재할 시 (select박스로 주문상태 선택시)
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
			// 날짜를 기준으로 내림차순 정렬
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersBean ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getString("order_num"));
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
	
	// 오버로딩 : order 리스트 만들기, state가 존재할 시 (select박스로 주문상태 선택시)
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
				ordersBean.setOrders_order_num(rs.getString("order_num"));
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
			String sql="SELECT * FROM orders WHERE num=?"; // orders의 인덱스를 기준으로 조회
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getString("order_num"));
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
	public ReceiverBean toViewReceiver(int num) {
		ReceiverBean receiverBean = null;
		
		try {
			String sql="SELECT * FROM receiver WHERE num=?"; // receiver의 인덱스를 기준으로 조회
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
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
	public ArrayList<OrdersDetailBean> toViewOrdersDetail(String orders_order_num) {
		ArrayList<OrdersDetailBean> ordersDetailBeans = new ArrayList<OrdersDetailBean>();
		
		try {
			String sql="SELECT * FROM orders_detail WHERE orders_order_num=?";
			// orders_detail에 인덱슬르 기준으로 조회
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, orders_order_num);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDetailBean ordersDetailBean = new OrdersDetailBean();
				ordersDetailBean.setNum(rs.getInt("num"));
				ordersDetailBean.setQuantity(rs.getInt("quantity"));
				ordersDetailBean.setOrders_order_num(rs.getString("orders_order_num"));
				ordersDetailBean.setProduct_num(rs.getInt("product_num"));
				ordersDetailBean.setReceiver_num(rs.getInt("receiver_num"));
				ordersDetailBean.setCode(rs.getString("code"));
				ordersDetailBean.setName(rs.getString("name"));
				ordersDetailBean.setImage(rs.getString("image"));
				ordersDetailBean.setPrice(rs.getInt("price"));
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
			// orders의 num을 기준으로 state 변경
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

	public int changeMemState(int state, int num) {
		int changeCount = 0;
		
		try {
			String sql="UPDATE member SET status = ? WHERE num=?";
			// memver 테이블의 num을 기준으로 status 변경
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

	// 마이페이지용, 아이디로 orders의 정보를 조회
	public List<OrdersBean> getMyOrders(String id) {
		List<OrdersBean> myOrders = new ArrayList<OrdersBean>();
		
		try {
			String sql="SELECT * FROM orders WHERE member_id=? AND state <> -1 ORDER BY regdate DESC";
			// id로 orders 테이블 조회 단, 주문취소 상태가 아닌 튜플만 출력
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersBean ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getString("order_num"));
				ordersBean.setOrders_state(rs.getInt("state"));
				ordersBean.setOrders_regdate(rs.getTimestamp("regdate"));
				ordersBean.setOrders_point(rs.getInt("point"));
				ordersBean.setOrders_total_price(rs.getInt("total_price"));
				ordersBean.setOrders_payMethod(rs.getString("pay_method"));
				myOrders.add(ordersBean);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return myOrders;
	}
	
	// 마이페이지용, 취소 및 반품목록
	public List<OrdersBean> getMyCancleOrders(String id) {
		List<OrdersBean> myOrders = new ArrayList<OrdersBean>();
		
		try {
			String sql="SELECT * FROM orders WHERE member_id=? AND state = -1 ORDER BY regdate DESC";
			// id로 orders 테이블 조회 단,주문취소 상태인 튜플만 출력
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersBean ordersBean = new OrdersBean();
				ordersBean.setOrders_num(rs.getInt("num"));
				ordersBean.setOrders_order_num(rs.getString("order_num"));
				ordersBean.setOrders_state(rs.getInt("state"));
				ordersBean.setOrders_regdate(rs.getTimestamp("regdate"));
				ordersBean.setOrders_point(rs.getInt("point"));
				ordersBean.setOrders_total_price(rs.getInt("total_price"));
				ordersBean.setOrders_payMethod(rs.getString("pay_method"));
				myOrders.add(ordersBean);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return myOrders;
	}
	
	// 구매 확정후 상태 변경
	public int changeBuyState(String orders_order_num) {
		int changeCount = 0;
		try {
			String sql="UPDATE orders SET state = 3 WHERE order_num=?";
			// 주문코드를 기준으로 state 값 변경
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, orders_order_num);
			
			changeCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return changeCount;
	}
	
	// 구매 확정후 포인트 변경
	public int changeBuyPoint(int point, String id) {
		int changeCount = 0;
		
		try {
			String sql="CALL update_point('구매 확정','구매 확정에 따른 포인트 적립','적립',?,?)";
			//update_point 프로시저 사용, point 테이블에 튜플 추가 및 member 테이블에 point값 변경
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setString(2, id);
			
			changeCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return changeCount;
	}
	
	// 구매 취소후 상태 변경
	public int changeCancleState(String orders_order_num) {
		int changeCount = 0;
		
		try {
			String sql="UPDATE orders SET state = -1 WHERE order_num=?";
			//주문코드를 기준으로 조회, 주문취소 시 state값 변경
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, orders_order_num);
			
			changeCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return changeCount;
	}
	
	// 구매 취소후 포인트 변경
	public int changeCanclePoint(int point, String id) {
		int changeCount = 0;
		
		try {
			String sql="CALL update_point('구매 취소','구매 취소에 따른 금액 포인트로 환불','적립',?,?)";
			//update_point 프로시저 사용, point 테이블에 튜플 추가 및 member 테이블에 point값 변경
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setString(2, id);
			
			changeCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return changeCount;
	}
	
	// 구매확정 버튼 클릭시, 회원 등급 최신화
	public int changeGrade(String id) {
		int changeCount = 0;
		
		try {
			String sql="UPDATE member SET grade = "+ 
					"IF((SELECT SUM(total_price) FROM orders WHERE member_id=?)>=200000," + 
					"'GOLD',IF((SELECT SUM(total_price) FROM orders WHERE member_id=?)>=500000,'DIAMOND','SILVER')) " + 
					"WHERE id=?";
			// orders테이블에서 member_id를 통해 구매액 총합을 구하고 그 값이 500000 이상이면 DIAMOND, 200000 이상이면 GOLD, 그 이하이면 SILVER이다.
			// 참고로 회원가입 최초시 기본값은 BRONZ 이고 구매 1회  이상시 SILVER로 변경됨
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			pstmt.setString(3, id);
			
			changeCount = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return changeCount;
	}

	// 베스트10 구하기
	public ArrayList<ProductBean> toBestProduct() {
		ArrayList<ProductBean> bestList= new ArrayList<ProductBean>();
		
		try {
			String sql="SELECT num,name,image,price,sale_price FROM product LEFT OUTER JOIN\r\n" + 
					"(SELECT product_num,cnt_order,cnt_review FROM (SELECT product_num, SUM(quantity) 'cnt_order' FROM orders_detail GROUP BY product_num) cnt1\r\n" + 
					"LEFT OUTER JOIN (SELECT product_num 'tmp_pn', COUNT(num) 'cnt_review' FROM review GROUP BY product_num) cnt2\r\n" + 
					"ON cnt1.product_num = cnt2.tmp_pn) cnt_tbl\r\n" + 
					"ON product.num = cnt_tbl.product_num\r\n" + 
					"ORDER BY cnt_order DESC, regdate DESC limit 0,10;";
			// count 뷰를 활용해 1차적으로 주문량이 가장 많은 상품을 구하고 2차적으로 등록날짜 내림차순 기준으로 10개의 상품을 구한다.
			pstmt=con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ProductBean productBean = new ProductBean();
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
//				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
//				productBean.setProduct_description(rs.getString("description"));
				productBean.setProduct_price(rs.getInt("price"));
//				productBean.setProduct_brand(rs.getString("brand"));
//				productBean.setProduct_stock_count(rs.getInt("stock_count"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
//				productBean.setProduct_keywords(rs.getString("keywords"));
//				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
//				productBean.setProduct_category_code(rs.getString("category_code"));
//				productBean.setProduct_option_code(rs.getString("option_code"));
				bestList.add(productBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return bestList;
		
	}

}
