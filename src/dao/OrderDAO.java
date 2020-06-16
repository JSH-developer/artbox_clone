package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import vo.BasketBean;
import vo.BasketTestMemberBean;
import vo.OrdersBean;
import vo.OrdersDetailBean;
import vo.ProductBean;
import vo.ReceiverBean;
import vo.SelectOrderBean;

public class OrderDAO {
	public OrderDAO() {}
	
	private static OrderDAO instance = new OrderDAO();
	
	public static OrderDAO getInstance() {
		// OrderDAO 객체가 없을 경우에만 생성
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

	// 선택 주문
	public List<SelectOrderBean> OrderOneList(String member_id, int basket_num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SelectOrderBean bean = new SelectOrderBean();
		
		List<SelectOrderBean> OrderList = new ArrayList<SelectOrderBean>();
		try {
			String sql = "SELECT member.name, member.email, member.phone, member.point, "
					+ "product.num, product.code, product.name, product.image, product.price, basket.quantity "
					+ "FROM member INNER JOIN basket ON member.id = basket.member_id "
					+ "INNER JOIN product ON product.num = basket.product_num "
					+ "WHERE member_id=? AND basket.num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, basket_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("member.name"));
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
//	public List OrderAllList(String member_id/*, int basketidx*/) {
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		
//		List list = new ArrayList();
//		List productList = new ArrayList();
//		List basketList = new ArrayList();
//		List memberList = new ArrayList();
//		try {
//			String sql = "SELECT member.name, member.postcode, member.addr_basic, "
//					+ "member.addr_detail, member.email, member.phone, member.point, "
//					+ "product.num, product.code, product.name, product.image, product.price, basket.quantity "
//					+ "FROM member INNER JOIN basket ON member.id = basket.member_id "
//					+ "INNER JOIN product ON product.num = basket.product_num "
//					+ "WHERE member_id=?"; //  AND basket.num=?
//			pstmt = con.prepareStatement(sql);
//			pstmt.setString(1, member_id);
////			pstmt.setInt(2, basketidx);
//			rs = pstmt.executeQuery();
//			while(rs.next()) {
//				ProductBean productBean = new ProductBean();
//				BasketBean basketBean = new BasketBean();
//				BasketTestMemberBean memberBean = new BasketTestMemberBean();
//				productBean.setProduct_num(rs.getInt("num"));
//				productBean.setProduct_code(rs.getString("code"));
//				productBean.setProduct_name(rs.getString("name"));
//				productBean.setProduct_image(rs.getString("image"));
//				productBean.setProduct_price(rs.getInt("price"));
//				productList.add(productBean);
//				basketBean.setBasket_quantity(rs.getInt("quantity"));
//				basketList.add(basketBean);
//				memberBean.setName(rs.getString("name"));
//				memberBean.setPostcode(rs.getString("postcode"));
//				memberBean.setAddr_basic(rs.getString("addr_basic"));
//				memberBean.setAddr_detail(rs.getString("addr_detail"));
//				memberBean.setEmail(rs.getString("email"));
//				memberBean.setPhone(rs.getString("phone"));
//				memberBean.setPoint(rs.getInt("point"));
//				memberList.add(memberBean);
//			}
//			list.add(productList);
//			list.add(basketList);
//			list.add(memberList);
//		} catch (SQLException e) {
////			e.printStackTrace();
//			System.out.println("OrderDAO - selectOrderList() 실패! : " + e.getMessage());
//		} finally {
//			close(rs);
//			close(pstmt);
//		}
//		return list;
//	}

	// 주문 테이블 INSERT
	public int insertOrder(OrdersBean ordersbean) {
		System.out.println("OrderDAO - insertOrder");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertOrderCount = 0;
		int num = 1; // 번호
		int orders_num = 0; // 주문번호
		Calendar cal=Calendar.getInstance();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		try {
			// orders 번호 구하기
			String sql="SELECT MAX(num) FROM orders";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}
			orders_num = num;
			
			// 주문 INSERT
			sql="INSERT INTO orders VALUES(?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, sdf.format(cal.getTime()).toString()+String.format("%06d", orders_num));//주문번호
			pstmt.setString(3, ordersbean.getOrders_member_id());
			pstmt.setString(4, ordersbean.getOrders_order_name());
			pstmt.setString(5, ordersbean.getOrders_order_email());
			pstmt.setString(6, ordersbean.getOrders_order_phone());
			pstmt.setInt(7, ordersbean.getOrders_point());
			pstmt.setInt(8, ordersbean.getOrders_total_price());
			pstmt.setString(9, ordersbean.getOrders_payMethod());
			pstmt.setInt(10, ordersbean.getOrders_state());
			insertOrderCount = pstmt.executeUpdate();
			
			System.out.println(num + ", " + sdf.format(cal.getTime()).toString()+String.format("%06d", orders_num) + ", " + ordersbean.getOrders_member_id()
			 + ", " + ordersbean.getOrders_order_name() + ", " + ordersbean.getOrders_order_email() + ", " + ordersbean.getOrders_order_phone() + ", " + ordersbean.getOrders_point() + ", " + ordersbean.getOrders_total_price() 
			 + ", " + ordersbean.getOrders_payMethod() + ", " + ordersbean.getOrders_state());
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - insertOrder() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertOrderCount;
	}

	// 배송지 테이블 INSERT (마이페이지 사용)
	public int insertReceiver(ReceiverBean receiverBean, String id) {
		System.out.println("OrderDAO - insertReceiver");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertReceiverCount = 0;
		int num = 1; // 번호
		int basic_num = 0; // 기본배송지 여부(1:기본배송지)
		try {
			// receiver 번호 구하기
			String sql="SELECT MAX(num) FROM receiver";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}
			
			// 배송지 INSERT
			sql="INSERT INTO receiver VALUES(?,?,?,?,?,?,?,?,now(),?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, receiverBean.getReceiver());
			pstmt.setString(3, receiverBean.getReceiver_name());
			pstmt.setString(4, receiverBean.getReceiver_phone());
			pstmt.setString(5, receiverBean.getReceiver_postcode());
			pstmt.setString(6, receiverBean.getReceiver_addr());
			pstmt.setString(7, receiverBean.getReceiver_addr_detail());
			pstmt.setString(8, receiverBean.getReceiver_msg());
			pstmt.setString(9, id);
			pstmt.setInt(10, basic_num);
			insertReceiverCount = pstmt.executeUpdate();
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - insertReceiver() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertReceiverCount;
	}
	
	// Orders_Detail 테이블 INSERT
	public int insertDetail(List basketList, List itemList, String id) {
		System.out.println("OrderDAO - insertDetail");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertDetailCount = 0;
		int num = 1; // 번호
		String orders_num = "0"; // 주문번호
		int receiver_num = 0; // 배송지번호
		try {
			System.out.println("1번");
			// orders_detail 번호 구하기
			String sql="SELECT MAX(num) FROM orders_detail";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}

			System.out.println("2번");
			// 주문번호 불러오기
			sql = "SELECT MAX(order_num) FROM orders WHERE member_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				orders_num = rs.getString(1);
			}

			System.out.println("3번");
			// 배송지번호 불러오기
			sql = "SELECT r.num FROM receiver r INNER JOIN orders o ON r.receiver_date = o.regdate WHERE r.member_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				receiver_num = rs.getInt(1);
			}

			System.out.println("4번");
			System.out.println("num값" + num);
			System.out.println("orders_num값" + orders_num);
			System.out.println("receiver_num값" + receiver_num);
			// 주문상품만큼 INSERT
			for(int i=0;i<basketList.size();i++) {
				BasketBean basketBean=(BasketBean)basketList.get(i);
				ProductBean productBean=(ProductBean)itemList.get(i);
				sql="INSERT INTO orders_detail VALUES(?,?,?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setInt(2, basketBean.getBasket_quantity());
				pstmt.setString(3, orders_num);//주문번호
				pstmt.setInt(4, basketBean.getBasket_product_num());
				pstmt.setInt(5, receiver_num); // 배송지번호
				pstmt.setString(6, productBean.getProduct_code());
				pstmt.setString(7, productBean.getProduct_name());
				pstmt.setString(8, productBean.getProduct_image());
				pstmt.setInt(9, productBean.getProduct_price());
				insertDetailCount = pstmt.executeUpdate();
				num++; //일련번호증가
				System.out.println(i + "번ㅎㅎㅎ");
			}
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - insertDetail() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertDetailCount;
	}

	public List getDetailList(String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String order_num = null;
		List list = new ArrayList();
		
		try {
			String sql = "SELECT * FROM orders_detail WHERE orders_order_num=(SELECT MAX(orders_order_num)"
					+ " FROM orders_detail INNER JOIN orders ON order_num=orders_order_num WHERE member_id=?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
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
				order_num = rs.getString("orders_order_num");
				
				ResultSet rs2 = null;
				sql = "SELECT total_price, pay_method, regdate FROM orders WHERE order_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, order_num);
				rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					ordersDetailBean.setOrders_regdate(rs2.getTimestamp("regdate"));
					ordersDetailBean.setOrders_total_price(rs2.getInt("total_price"));
					ordersDetailBean.setOrders_payMethod(rs2.getString("pay_method"));
				}
				
				sql = "SELECT receiver_name, receiver_phone, receiver_postcode, receiver_addr, receiver_addr_detail, receiver_msg"
						+ " FROM receiver r INNER JOIN orders o ON r.receiver_date = o.regdate WHERE r.member_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					ordersDetailBean.setReceiver_name(rs2.getString("receiver_name"));
					ordersDetailBean.setReceiver_phone(rs2.getString("receiver_phone"));
					ordersDetailBean.setReceiver_postcode(rs2.getString("receiver_postcode"));
					ordersDetailBean.setReceiver_addr(rs2.getString("receiver_addr"));
					ordersDetailBean.setReceiver_addr_detail(rs2.getString("receiver_addr_detail"));
					ordersDetailBean.setReceiver_msg(rs2.getString("receiver_msg"));
				}
				list.add(ordersDetailBean);
				close(rs2);
			}

		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - getDetailList() 실패! : " + e.getMessage());
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
		List basketList = new ArrayList();
		List productList = new ArrayList();
		List memberList = new ArrayList();
		try {
			String sql = "SELECT member.name, member.postcode, member.addr_basic, "
					+ "member.addr_detail, member.email, member.phone, member.point, "
					+ "product.num, product.code, product.name, product.image, product.price, basket.quantity "
					+ "FROM member INNER JOIN basket ON member.id = basket.member_id "
					+ "INNER JOIN product ON product.num = basket.product_num "
					+ "WHERE member_id=? AND  product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, product_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ProductBean productBean = new ProductBean();
				basketBean basketBean = new basketBean();
				basketTestMemberBean memberBean = new basketTestMemberBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_price(rs.getInt("price"));
				productList.add(productBean);
				basketBean.setbasket_quantity(rs.getInt("quantity"));
				basketList.add(basketBean);
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
			list.add(basketList);
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
