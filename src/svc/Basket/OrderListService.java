package svc.Basket;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import vo.SelectOrderBean;

public class OrderListService {

	public List getOrderList(String member_id, String product_num) { // 여러 개 주문
		System.out.println("OrderListService - getOrderList()");
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 orderDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		// 3. orderDAO 객체에 Connection 객체 전달
		orderDAO.setConnection(con);
		
		String[] arrOption = product_num.split(",");
		// 4. orderDAO 클래스의 OrderList() 메서드를 호출하여
		//    파라미터 : member_id, product_num
		//    리턴타입 : List
		
		List list = new ArrayList();
		for(String i:arrOption) {
			List<SelectOrderBean> basketList = new ArrayList<SelectOrderBean>();
			basketList = orderDAO.OrderList(member_id, Integer.parseInt(i));
			list.add(basketList);
		}
		
		// 5. Connection 객체 반환
		close(con);
		
		// 6. 작업 결과 리턴
		return list;
	}
	
	// 기본배송지
	public List getBasicReceiverList(String member_id) {
		System.out.println("ReceiverListService - getBasicReceiverList()");
		
		Connection con = getConnection();
		OrderDAO orderDAO = OrderDAO.getInstance();
		orderDAO.setConnection(con);
		
		List list = new ArrayList();
		list = orderDAO.getBasicReceiverList(member_id);
		
		close(con);
		
		return list;
	}
	
	// 최근배송지
	public List getLastReceiverList(String member_id) {
		System.out.println("ReceiverListService - getLastReceiverList()");
		
		Connection con = getConnection();
		OrderDAO orderDAO = OrderDAO.getInstance();
		orderDAO.setConnection(con);
		
		List list = new ArrayList();
		list = orderDAO.getLastReceiverList(member_id);

		close(con);
		
		return list;
	}
	
}
