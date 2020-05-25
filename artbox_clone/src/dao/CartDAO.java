package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import vo.CartBean;
import vo.ProductBean;

public class CartDAO {
	public CartDAO() {}
	
	private static CartDAO instance = new CartDAO();
	
	public static CartDAO getInstance() {
		// cartDAO 객체가 없을 경우에만 생성
		if(instance == null) {
			instance = new CartDAO();
		}
		return instance;
	}
	
	Connection con; // Connection 객체 전달받아 저장할 변수 선언
	
	// Service 클래스로부터 Connection 객체를 전달받는 메서드 setConnection() 정의
	public void setConnection(Connection con) {
		this.con = con; // 이름이 똑같기 때문에 this. 적음
	}
	
	// 장바구니 추가
	public int insertCart(CartBean cartBean) {
		// Service 클래스로부터 CartBean 객체를 전달받아 DB 에 INSERT 작업 수행
		// => 수행 결과 값으로 int형 insertCount 를 리턴받아 다시 Service 클래스로 리턴
		int insertCount = 0;
		
		// DB 작업에 필요한 변수 선언(Connection 객체는 이미 외부로부터 전달받음)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			int cart_num = 1; // 새 장바구니 번호를 저장할 변수(초기값으로 초기번호 1번 설정)
			
			String sql = "SELECT MAX(num) FROM cart";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 등록된 장바구니가 하나라도 존재할 경우 장바구니 번호 조회 성공
				// 조회된 번호 + 1 을 수행하여 새 장바구니 번호로 저장
				cart_num = rs.getInt(1) + 1;
			}
			// => 만약 조회가 실패할 경우 새 장바구니 번호는 1번이므로 기본값 cart_num 그대로 사용
			
			// 전달받은 데이터와 계산된 장바구니 번호를 사용하여 INSERT 작업 수행
			sql = "INSERT INTO cart VALUES(?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			pstmt.setInt(2, cartBean.getCart_quantity());
			pstmt.setString(3, cartBean.getCart_member_id());
			pstmt.setInt(4, cartBean.getCart_product_num());
			
			// INSERT 구문 실행 후 리턴되는 결과값을 insertCount 변수에 저장
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - insertCart() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertCount;
	}
	
	// 장바구니 목록
	public List selectCartList(String member_id) {
		// member_id 에 해당하는 장바구니 목록 전체 조회
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		List list = new ArrayList();
		List cartList = new ArrayList();
		List itemsList = new ArrayList();
		
		try {
			String sql = "SELECT * FROM cart WHERE member_id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartBean cart = new CartBean();
				cart.setCart_num(rs.getInt("num"));
				cart.setCart_quantity(rs.getInt("quantity"));
				cart.setCart_regdate(rs.getTimestamp("regdate"));
				cart.setCart_product_num(rs.getInt("product_num"));
				cart.setCart_member_id(rs.getString("member_id"));
				cartList.add(cart);
				
				// num 에 해당하는 상품 조회해오기
				sql = "SELECT * FROM product WHERE num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, cart.getCart_product_num());
				rs2 = pstmt2.executeQuery();
				if(rs2.next()) {
					ProductBean productBean = new ProductBean();
					productBean.setProduct_code(rs2.getString("code"));
					productBean.setProduct_price(rs2.getInt("price"));
					productBean.setProduct_name(rs2.getString("name"));
					productBean.setProduct_image(rs2.getString("image"));
					itemsList.add(productBean);
				}
			}
			// list 첫번째 칸 cartList 저장
			list.add(cartList);
			// list 두번째 칸 itemsList 저장
			list.add(itemsList);
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - selectCartList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
//			close(rs2);
//			close(pstmt2);
		}
		return list;
	}

	// 장바구니에 담겨있는 상품일 경우, 수량 추가
	public int checkItems(CartBean cartBean) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		try{
			// 장바구니에 이미 담겨있는 상품인지 조회
			String sql = "SELECT * FROM cart WHERE member_id=? AND product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cartBean.getCart_member_id());
			pstmt.setInt(2, cartBean.getCart_product_num());
			
			rs=pstmt.executeQuery();
			// rs 데이터 있으면 check=1
			if(rs.next()){
				check = 1;
				// 장바구니에 있는 상품일 경우, 상품 개수만 증가시킴
				sql="UPDATE cart SET quantity=quantity+? WHERE member_id=? AND product_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, cartBean.getCart_quantity());
				pstmt.setString(2, cartBean.getCart_member_id());
				pstmt.setInt(3, cartBean.getCart_product_num());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - checkItems() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return check;
	}
	
	// 수량 변경
	public int updateQuantity(int quantity, int num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int updateCount = 0;
		try{
			String sql = "SELECT * FROM cart WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			// rs 데이터 있으면 updateCount=1
			if(rs.next()){
				updateCount = 1;
				sql="UPDATE cart SET quantity=? WHERE num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, quantity);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - updateQuantity() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return updateCount;
	}
	
	// 선택 삭제
	public int deleteCart(int cart_num){
		PreparedStatement pstmt = null;
		int deleteCount = 0;
		try {
			String sql = "DELETE FROM cart WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - deleteCart() 실패! : " + e.getMessage());
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}
	
	// 전체 삭제(주문페이지로 넘어갈 경우 장바구니 전체삭제)
	public int deleteAllCart(String member_id){
		PreparedStatement pstmt = null;
		int deleteCount = 0;
		try {
			String sql = "DELETE FROM cart WHERE member_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - deleteAllCart() 실패! : " + e.getMessage());
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}
	
}
