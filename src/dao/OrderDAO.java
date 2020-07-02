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
	
	// 주문 목록 출력 - 바로 주문(itemDetail.jsp 에서)
	public List<SelectOrderBean> OrderDirectList(String id, ProductBean productBean) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SelectOrderBean bean = new SelectOrderBean();
		
		List<SelectOrderBean> OrderList = new ArrayList<SelectOrderBean>();
		try {
			String sql = "SELECT name, email, phone, point FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				bean.setPhone(rs.getString("phone"));
				bean.setPoint(rs.getInt("point"));
				bean.setItemNum(productBean.getProduct_num());
				bean.setItemCode(productBean.getProduct_code());
				bean.setItemName(productBean.getProduct_name());
				bean.setItemImage(productBean.getProduct_image());
				bean.setItemprice(productBean.getProduct_price());
				bean.setQuantity(productBean.getProduct_stock_count()); // 상품 수량 임시로 사용
				bean.setItemCategory(productBean.getProduct_category_code());
				OrderList.add(bean);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - OrderDirectList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return OrderList;
	}
	
	// 주문 목록 출력(OrderPay.jsp) - 장바구니를 거치는 주문
	public List<SelectOrderBean> OrderList(String member_id, int product_num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SelectOrderBean bean = new SelectOrderBean();
		
		List<SelectOrderBean> OrderList = new ArrayList<SelectOrderBean>();
		try {
			String sql = "SELECT member.name, member.email, member.phone, member.point, product.num,"
					+ " product.code, product.name, product.image, product.price, basket.quantity, product.category_code"
					+ " FROM member JOIN basket ON member.id = basket.member_id"
					+ " JOIN product ON product.num = basket.product_num"
					+ " WHERE member_id=? AND basket.product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, product_num);
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
				bean.setItemCategory(rs.getString("category_code"));
				OrderList.add(bean);
			}
		} catch (SQLException e) {
//				e.printStackTrace();
			System.out.println("OrderDAO - OrderList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return OrderList;
	}
	
	// 주문 테이블 INSERT
	public int insertOrder(OrdersBean ordersbean) {
		System.out.println("OrderDAO - insertOrder");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertOrderCount = 0;
		int num = 1; // 번호
		int orders_num = 0; // 주문번호
		Calendar cal = Calendar.getInstance();
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
			sql="INSERT INTO orders VALUES(?,?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, sdf.format(cal.getTime()).toString()+String.format("%06d", orders_num)); // 주문번호
			pstmt.setString(3, ordersbean.getOrders_member_id());
			pstmt.setString(4, ordersbean.getOrders_order_name());
			pstmt.setString(5, ordersbean.getOrders_order_email());
			pstmt.setString(6, ordersbean.getOrders_order_phone());
			pstmt.setString(7, ordersbean.getOrders_msg());
			pstmt.setInt(8, ordersbean.getOrders_point());
			pstmt.setInt(9, ordersbean.getOrders_total_price());
			pstmt.setString(10, ordersbean.getOrders_payMethod());
			pstmt.setInt(11, ordersbean.getOrders_state());
			insertOrderCount = pstmt.executeUpdate();
			
			System.out.println(num + ", " + sdf.format(cal.getTime()).toString()+String.format("%06d", orders_num) + ", " + ordersbean.getOrders_member_id()
			 + ", " + ordersbean.getOrders_order_name() + ", " + ordersbean.getOrders_order_email() + ", " + ordersbean.getOrders_order_phone() 
			 + ", " + ordersbean.getOrders_msg() + ", " + ordersbean.getOrders_point() + ", " + ordersbean.getOrders_total_price() 
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

	// 기본 배송지 여부 0 으로 초기화 - default 0, 1:기본배송지 (Receiver 테이블 공통부분)
	public void basicReceiver(String member_id, int num) {
		System.out.println("OrderDAO - basicReceiver");
		PreparedStatement pstmt = null;
		try {
			String sql="UPDATE receiver SET basic_num=0 WHERE member_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.executeUpdate();
			sql="UPDATE receiver SET basic_num=1 WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - basicReceiver() 실패! : " + e.getMessage());
		} finally {
			close(pstmt);
		}
	}

	// 배송지 테이블 INSERT (주문 및 마이페이지 사용)
	public int insertReceiver(ReceiverBean receiverBean) {
		System.out.println("OrderDAO - insertReceiver");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int insertReceiverCount = 0;
		int num = 1; // 번호
		int basic_num = receiverBean.getReceiver_basic_num(); // 기본배송지 여부 (default 0, 1:기본배송지)
		try {
			// 기본배송지
			if(basic_num==1) { // 기본배송지 체크해서 가져오면 기본배송지 업데이트
				basicReceiver(receiverBean.getReceiver_member_id(), receiverBean.getReceiver_num());
			}
			// receiver 중복 여부 판별
			sql="SELECT num FROM receiver WHERE member_id=? && receiver_name=? && receiver_phone=?"
					+ " && receiver_postcode=? && receiver_addr=? && receiver_addr_detail=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, receiverBean.getReceiver_member_id());
			pstmt.setString(2, receiverBean.getReceiver_name());
			pstmt.setString(3, receiverBean.getReceiver_phone());
			pstmt.setString(4, receiverBean.getReceiver_postcode());
			pstmt.setString(5, receiverBean.getReceiver_addr());
			pstmt.setString(6, receiverBean.getReceiver_addr_detail());
			rs=pstmt.executeQuery();
			if(rs.next()) { // 값이 있으면 중복
				System.out.println("값이 있음");
				sql="UPDATE receiver SET receiver_date=now(), basic_num=? WHERE member_id=? &&"
						+ " receiver_name=? && receiver_phone=? && receiver_postcode=? && receiver_addr=?"
						+ " && receiver_addr_detail=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,basic_num);
				pstmt.setString(2, receiverBean.getReceiver_member_id());
				pstmt.setString(3, receiverBean.getReceiver_name());
				pstmt.setString(4, receiverBean.getReceiver_phone());
				pstmt.setString(5, receiverBean.getReceiver_postcode());
				pstmt.setString(6, receiverBean.getReceiver_addr());
				pstmt.setString(7, receiverBean.getReceiver_addr_detail());
				insertReceiverCount = pstmt.executeUpdate();
			} else { // 값이 없으면 새배송지 추가
				sql="SELECT MAX(num) FROM receiver";
				pstmt=con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					num = rs.getInt(1)+1;
					// 배송지 INSERT
					System.out.println("값이 없음");
					sql="INSERT INTO receiver VALUES(?,?,?,?,?,?,?,now(),?,?)";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, basic_num==1?"기본":receiverBean.getReceiver());
					pstmt.setString(3, receiverBean.getReceiver_name());
					pstmt.setString(4, receiverBean.getReceiver_phone());
					pstmt.setString(5, receiverBean.getReceiver_postcode());
					pstmt.setString(6, receiverBean.getReceiver_addr());
					pstmt.setString(7, receiverBean.getReceiver_addr_detail());
					pstmt.setString(8, receiverBean.getReceiver_member_id());
					pstmt.setInt(9, basic_num);
					insertReceiverCount = pstmt.executeUpdate();
				}
			}
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - insertReceiver() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertReceiverCount;
	}
	
	// 배송지 수정 (마이페이지 사용)
	public int updateReceiver(ReceiverBean receiverBean) {
		System.out.println("OrderDAO - updateReceiver");
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int updateReceiverCount = 0;
		int basic_num = receiverBean.getReceiver_basic_num(); // 기본배송지 여부 (default 0, 1:기본배송지)
		try {
			// 기본배송지
			if(basic_num==1) { // 기본배송지 체크해서 가져오면 기본배송지 업데이트
				basicReceiver(receiverBean.getReceiver_member_id(), receiverBean.getReceiver_num());
			}
			// receiver 수정
			sql="UPDATE receiver SET receiver=?, receiver_name=?, receiver_phone=?, receiver_postcode=?,"
					+ " receiver_addr=?, receiver_addr_detail=?, basic_num=? WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, receiverBean.getReceiver());
			pstmt.setString(2, receiverBean.getReceiver_name());
			pstmt.setString(3, receiverBean.getReceiver_phone());
			pstmt.setString(4, receiverBean.getReceiver_postcode());
			pstmt.setString(5, receiverBean.getReceiver_addr());
			pstmt.setString(6, receiverBean.getReceiver_addr_detail());
			pstmt.setInt(7, basic_num);
			pstmt.setInt(8, receiverBean.getReceiver_num());
			updateReceiverCount = pstmt.executeUpdate();
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - updateReceiver() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return updateReceiverCount;
	}
	
	// 배송지 삭제 (마이페이지 사용)
	public int deleteReceiver(int receiver_num){
		System.out.println("OrderDAO - deleteReceiver");
		PreparedStatement pstmt = null;
		int deleteCount = 0;
		try {
			String sql = "DELETE FROM receiver WHERE num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, receiver_num);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
//				e.printStackTrace();
			System.out.println("OrderDAO - deleteReceiver() 실패! : " + e.getMessage());
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}

	// 기본배송지 가져오기 (OrderPay.jsp 와 마이페이지 배송지관리에서 사용)
	public List getBasicReceiverList(String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list = new ArrayList();

		try {
			String sql = "SELECT * FROM receiver WHERE member_id=? AND receiver NOT IN('') ORDER BY basic_num DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReceiverBean receiverBean = new ReceiverBean();
				receiverBean.setReceiver_num(rs.getInt("num"));
				receiverBean.setReceiver(rs.getString("receiver"));
				receiverBean.setReceiver_name(rs.getString("receiver_name"));
				receiverBean.setReceiver_phone(rs.getString("receiver_phone"));
				receiverBean.setReceiver_postcode(rs.getString("receiver_postcode"));
				receiverBean.setReceiver_addr(rs.getString("receiver_addr"));
				receiverBean.setReceiver_addr_detail(rs.getString("receiver_addr_detail"));
				receiverBean.setReceiver_date(rs.getString("receiver_date"));
				receiverBean.setReceiver_member_id(rs.getString("member_id"));
				receiverBean.setReceiver_basic_num(rs.getInt("basic_num"));
				list.add(receiverBean);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - getBasicReceiverList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	// 최근배송지 가져오기 (OrderPay.jsp)
	public List getLastReceiverList(String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List list = new ArrayList();
		
		try {
			String sql = "SELECT * FROM receiver WHERE num IN(SELECT receiver_num FROM orders_detail od"
					+ " JOIN receiver r ON r.num=od.receiver_num) AND member_id=? ORDER BY receiver_date DESC LIMIT 3";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReceiverBean receiverBean = new ReceiverBean();
				receiverBean.setReceiver_num(rs.getInt("num"));
				receiverBean.setReceiver(rs.getString("receiver"));
				receiverBean.setReceiver_name(rs.getString("receiver_name"));
				receiverBean.setReceiver_phone(rs.getString("receiver_phone"));
				receiverBean.setReceiver_postcode(rs.getString("receiver_postcode"));
				receiverBean.setReceiver_addr(rs.getString("receiver_addr"));
				receiverBean.setReceiver_addr_detail(rs.getString("receiver_addr_detail"));
				receiverBean.setReceiver_date(rs.getString("receiver_date"));
				receiverBean.setReceiver_member_id(rs.getString("member_id"));
				receiverBean.setReceiver_basic_num(rs.getInt("basic_num"));
				list.add(receiverBean);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - getLastReceiverList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	// 주문 상세보기 INSERT
	public int insertDetail(List orderList, String id) {
		System.out.println("OrderDAO - insertDetail");
		System.out.println("확인하기" + orderList);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int insertDetailCount = 0; // INSERT 성공 여부
		int updateCount = 0; // 수량변경 성공 여부
		int num = 1; // 번호
		String orders_num = "0"; // 주문번호
		int receiver_num = 0; // 배송지번호
		try {
			// orders_detail 번호 구하기
			String sql="SELECT MAX(num) FROM orders_detail";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				num = rs.getInt(1)+1;
			}
			// 주문번호 불러오기
			sql = "SELECT MAX(order_num) FROM orders WHERE member_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				orders_num = rs.getString(1);
			}
			// 배송지번호 불러오기
			sql = "SELECT r.num FROM receiver r JOIN orders o ON r.receiver_date = o.regdate WHERE r.member_id=?"
					+ " ORDER BY o.regdate DESC LIMIT 1";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				receiver_num = rs.getInt(1);
			}
			// 주문상품만큼 INSERT
			for(int i = 0; i < orderList.size(); i++) {
				List list =  (List)orderList.get(i);
				ProductBean bean = (ProductBean)list.get(0);
				sql="INSERT INTO orders_detail VALUES(?,?,?,?,?,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setInt(2, bean.getProduct_stock_count());
				pstmt.setString(3, orders_num);//주문번호
				pstmt.setInt(4, bean.getProduct_num());
				pstmt.setInt(5, receiver_num); // 배송지번호
				pstmt.setString(6, bean.getProduct_code());
				pstmt.setString(7, bean.getProduct_name());
				pstmt.setString(8, bean.getProduct_image());
				pstmt.setInt(9, bean.getProduct_price());
				
				insertDetailCount = pstmt.executeUpdate();
				num++; //일련번호증가
				if(insertDetailCount > 0) {
					sql="UPDATE product SET stock_count=stock_count-? WHERE code=?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1, bean.getProduct_stock_count());
					pstmt.setString(2, bean.getProduct_code());
					updateCount = pstmt.executeUpdate();
				}
			}
		}  catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - insertDetail() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return updateCount;
	}

	// 주문 상세보기 목록 출력 (OrderPayComplete.jsp 및 마이페이지 사용)
	public List getDetailList(String id) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		String order_num = null;
		List list = new ArrayList();
		
		try {
			String sql = "SELECT * FROM orders_detail WHERE orders_order_num=(SELECT MAX(orders_order_num)"
					+ " FROM orders_detail JOIN orders ON order_num=orders_order_num WHERE member_id=?)";
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
				
				sql = "SELECT msg, total_price, pay_method, regdate FROM orders WHERE order_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, order_num);
				rs2 = pstmt.executeQuery();
				if(rs2.next()) {
					ordersDetailBean.setOrders_msg(rs2.getString("msg"));
					ordersDetailBean.setOrders_regdate(rs2.getTimestamp("regdate"));
					ordersDetailBean.setOrders_total_price(rs2.getInt("total_price"));
					ordersDetailBean.setOrders_payMethod(rs2.getString("pay_method"));
				}
				
				sql = "SELECT receiver_name, receiver_phone, receiver_postcode, receiver_addr, receiver_addr_detail"
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
				}
				list.add(ordersDetailBean);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("OrderDAO - getDetailList() 실패! : " + e.getMessage());
		} finally {
			close(rs2);
			close(rs);
			close(pstmt);
		}
		return list;
	}

	public List OrderItemList(int product_num, int qty) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductBean bean = new ProductBean();
		List OrderList = new ArrayList();
		try {
			String sql = "SELECT code, name, image, price FROM product WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setProduct_stock_count(qty); // 수량 담음
				bean.setProduct_num(product_num);
				bean.setProduct_code(rs.getString("code"));
				bean.setProduct_name(rs.getString("name"));
				bean.setProduct_image(rs.getString("image"));
				bean.setProduct_price(rs.getInt("price"));
				OrderList.add(bean);
			}
		} catch (SQLException e) {
//				e.printStackTrace();
			System.out.println("OrderDAO - OrderItemList() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return OrderList;
	}

}
