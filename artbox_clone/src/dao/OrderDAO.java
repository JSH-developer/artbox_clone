package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.CartBean;
import vo.CartTestMemberBean;
import vo.ProductBean;
import vo.SelectOrderBean;

public class OrderDAO {
	public OrderDAO() {}
	
	private static OrderDAO instance = new OrderDAO();
	
	public static OrderDAO getInstance() {
		// cartDAO 객체가 없을 경우에만 생성
		if(instance == null) {
			instance = new OrderDAO();
		}
		return instance;
	}
	
	Connection con; // Connection 객체 전달받아 저장할 변수 선언
	
	// Service 클래스로부터 Connection 객체를 전달받는 메서드 setConnection() 정의
	public void setConnection(Connection con) {
		this.con = con; // 이름이 똑같기 때문에 this. 적음
	}

	// 하나 주문
	public ArrayList<SelectOrderBean> OrderOneList(String member_id, int cart_num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SelectOrderBean bean = new SelectOrderBean();
		
		ArrayList<SelectOrderBean> OrderList = new ArrayList<SelectOrderBean>();
		try {
			String sql = "SELECT member.name, member.postcode, member.addr_basic, "
					+ "member.addr_detail, member.email, member.phone, member.point, "
					+ "product.num, product.code, product.name, product.image, product.price, cart.quantity "
					+ "FROM member INNER JOIN cart ON member.id = cart.member_id "
					+ "INNER JOIN product ON product.num = cart.product_num "
					+ "WHERE member_id=? AND cart.num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, cart_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("member.name"));
				bean.setPostcode(rs.getString("postcode"));
				bean.setAddr_basic(rs.getString("addr_basic"));
				bean.setAddr_detail(rs.getString("addr_detail"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setPoint(rs.getInt("point"));
				bean.setItemNum(rs.getInt("num"));
				bean.setItemCode(rs.getString("code"));
				bean.setItemName(rs.getString("product.name"));
				bean.setItemImage(rs.getString("image"));
				bean.setItemprice(rs.getInt("price"));
				bean.setQuantity(rs.getInt("quantity"));
				OrderList.add(bean);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - selectOrderList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return OrderList;
	}
	
	
	// 전체 주문
	public List OrderAllList(String member_id/*, int cartidx*/) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List list = new ArrayList();
		List productList = new ArrayList();
		List cartList = new ArrayList();
		List memberList = new ArrayList();
		try {
			String sql = "SELECT member.name, member.postcode, member.addr_basic, "
					+ "member.addr_detail, member.email, member.phone, member.point, "
					+ "product.num, product.code, product.name, product.image, product.price, cart.quantity "
					+ "FROM member INNER JOIN cart ON member.id = cart.member_id "
					+ "INNER JOIN product ON product.num = cart.product_num "
					+ "WHERE member_id=?"; //  AND cart.num=?
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
//			pstmt.setInt(2, cartidx);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean productBean = new ProductBean();
				CartBean cartBean = new CartBean();
				CartTestMemberBean memberBean = new CartTestMemberBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_price(rs.getInt("price"));
				productList.add(productBean);
				cartBean.setCart_quantity(rs.getInt("quantity"));
				cartList.add(cartBean);
				memberBean.setName(rs.getString("name"));
				memberBean.setPostcode(rs.getString("postcode"));
				memberBean.setAddr_basic(rs.getString("addr_basic"));
				memberBean.setAddr_detail(rs.getString("addr_detail"));
				memberBean.setEmail(rs.getString("email"));
				memberBean.setPhone(rs.getString("phone"));
				memberBean.setPoint(rs.getInt("point"));
				memberList.add(memberBean);
			}
			list.add(productList);
			list.add(cartList);
			list.add(memberList);
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - selectOrderList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
/*	
	// 하나 주문
	public List OrderOneList(String member_id, String product_num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List list = new ArrayList();
		List cartList = new ArrayList();
		List productList = new ArrayList();
		List memberList = new ArrayList();
		try {
			String sql = "SELECT member.name, member.postcode, member.addr_basic, "
					+ "member.addr_detail, member.email, member.phone, member.point, "
					+ "product.num, product.code, product.name, product.image, product.price, cart.quantity "
					+ "FROM member INNER JOIN cart ON member.id = cart.member_id "
					+ "INNER JOIN product ON product.num = cart.product_num "
					+ "WHERE member_id=? AND  product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, product_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ProductBean productBean = new ProductBean();
				CartBean cartBean = new CartBean();
				CartTestMemberBean memberBean = new CartTestMemberBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_price(rs.getInt("price"));
				productList.add(productBean);
				cartBean.setCart_quantity(rs.getInt("quantity"));
				cartList.add(cartBean);
				memberBean.setName(rs.getString("name"));
				memberBean.setPostcode(rs.getString("postcode"));
				memberBean.setAddr_basic(rs.getString("addr_basic"));
				memberBean.setAddr_detail(rs.getString("addr_detail"));
				memberBean.setEmail(rs.getString("email"));
				memberBean.setPhone(rs.getString("phone"));
				memberBean.setPoint(rs.getInt("point"));
				memberList.add(memberBean);
			}
			list.add(productList);
			list.add(cartList);
			list.add(memberList);
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - selectOrderList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
*/
}
