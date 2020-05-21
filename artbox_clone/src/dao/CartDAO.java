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
	public void insertCart(CartBean cartBean) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int cart_num = 1;
		try {
			String sql = "SELECT MAX(num) FROM cart";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cart_num = rs.getInt(1) + 1;
			}
			
			//3 sql insert  now()
			sql = "INSERT INTO cart VALUES(?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			pstmt.setInt(2, cartBean.getCart_quantity());
			pstmt.setInt(3, cartBean.getCart_product_num());
			pstmt.setString(4, cartBean.getCart_member_id());
			//4 실행
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - insertCart() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
	}
	
	// 장바구니 목록
	public Vector selectCartList(String member_id) {
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		Vector vector = new Vector();
		List cartList = new ArrayList();
		List itemsList = new ArrayList();
		
		int cart_num = 1;
		try {
			String sql = "SELECT * FROM cart WHERE member_id = ?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				CartBean cart = new CartBean();
				cart.setCart_num(rs.getInt("cart_num"));
				cart.setCart_quantity(rs.getInt("cart_quantity"));
				cart.setCart_regdate(rs.getTimestamp("cart_regdate"));
				cart.setCart_product_num(rs.getInt("cart_product_num"));
				cart.setCart_member_id(rs.getString("cart_member_id"));
				cartList.add(cart);
				sql = "SELECT * FROM product WHERE product_num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, cart.getCart_product_num());
				rs2 = pstmt2.executeQuery();
				if(rs2.next()) {
					ProductBean productBean = new ProductBean();
					productBean.setProduct_price(rs2.getInt("product_price"));
					productBean.setProduct_name(rs2.getString("product_name"));
					productBean.setProduct_image(rs2.getString("product_image"));
					itemsList.add(productBean);
				}
			}
			// vector 첫번째 칸 cartList 저장
			// vector 두번째 칸 itemsList 저장
			vector.add(cartList);
			vector.add(itemsList);
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - selectCartList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return vector;
	}

	// 장바구니에 담겨있는 상품일 경우, 수량 추가
	public int checkItems(CartBean cartBean) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		try{
			String sql = "SELECT * FROM cart WHERE cart_member_id=? and cart_product_num=? and cart_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cartBean.getCart_member_id());
			pstmt.setInt(2, cartBean.getCart_product_num());
			pstmt.setInt(3, cartBean.getCart_num());
			
			rs=pstmt.executeQuery();
			// rs 데이터 있으면 check=1
			if(rs.next()){
				check = 1;
				sql="UPDATE cart set cart_quantity=cart_quantity+? WHERE cart_member_id=? and cart_product_num=? and cart_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, cartBean.getCart_quantity());
				pstmt.setString(2, cartBean.getCart_member_id());
				pstmt.setInt(3, cartBean.getCart_product_num());
				pstmt.setInt(4, cartBean.getCart_num());
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
	
	// 선택 삭제
	public void deleteCart(int cart_num){
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "DELETE FROM cart WHERE cart_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - deleteCart() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
	}
	
	// 전체 삭제
	public void deleteAllCart(String cart_member_id){
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			String sql = "DELETE FROM cart WHERE cart_member_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cart_member_id);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("CartDAO - deleteAllCart() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
	}
	
}
