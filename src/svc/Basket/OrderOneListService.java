package svc.Basket;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import vo.SelectOrderBean;

public class OrderOneListService {

	public List getOrderOneList(String member_id, String arrBasket) { // 여러개 주문
		System.out.println("OrderOneListService - getOrderOneList() -장바구니 주문");
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 orderDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		// 3. orderDAO 객체에 Connection 객체 전달
		orderDAO.setConnection(con);
		
		String[] basketNumArr = arrBasket.split(",");
		// 4. orderDAO 클래스의 selectOrderList() 메서드를 호출하여
		//    파라미터 : member_id
		//    리턴타입 : List
		System.out.println("배열 너버"+basketNumArr);
		
		List list = new ArrayList();
		for(String i:basketNumArr) {
			System.out.println("도는지 확인~~");
			List<SelectOrderBean> basketList = new ArrayList<SelectOrderBean>();
			basketList = orderDAO.OrderOneList(member_id, Integer.parseInt(i));
			System.out.println("저장하는지 확인~~");
			list.add(basketList);
			System.out.println("리스트는" + list);
		}
		
/*
		// 4. orderDAO 클래스의 selectOrderList() 메서드를 호출하여
		//    파라미터 : member_id
		//    리턴타입 : List
		List list = orderDAO.OrderOneList(member_id, product_num);
 */
		System.out.println("여기도~~");
		// 5. Connection 객체 반환
		close(con);
		
		// 6. 작업 결과 리턴
		return list;
	}
	
	public List getBasicReceiverList(String member_id) {
		System.out.println("ReceiverListService - getReceiverList()");
		
		Connection con = getConnection();
		OrderDAO orderDAO = OrderDAO.getInstance();
		orderDAO.setConnection(con);
		
		List list = new ArrayList();
		list = orderDAO.getBasicReceiverList(member_id);
		
		close(con);
		
		return list;
	}
	
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
