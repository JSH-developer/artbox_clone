package svc.Basket;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import vo.SelectOrderBean;

public class OrderItemListService {

	public List getOrderItemList(String product_num, String stockqty) {
		System.out.println("OrderItemListService - getOrderItemList()");
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 orderDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		// 3. orderDAO 객체에 Connection 객체 전달
		orderDAO.setConnection(con);
		
		String[] arrOption = product_num.split(",");
		String[] arrQty = stockqty.split(",");
		// 4. orderDAO 클래스의 OrderList() 메서드를 호출하여
		//    파라미터 : member_id, product_num
		//    리턴타입 : List
		
		for(String i:arrQty) {
			System.out.println("차" + Integer.parseInt(i));
		}
		for(String i:arrOption) {
			System.out.println("핫" + Integer.parseInt(i));
		}
		List list = new ArrayList();
		for(int i = 0; i < arrOption.length; i++) {
			String optionIdx = arrOption[i];
			String stockQty = arrQty[i];
			List orderList = new ArrayList();
			orderList = orderDAO.OrderItemList(Integer.parseInt(optionIdx), Integer.parseInt(stockQty));
			list.add(orderList);
		}
//		for(String i:arrOption) {
//			String j = arrQty[];
//			List orderList = new ArrayList();
//			orderList = orderDAO.OrderItemList(Integer.parseInt(i), Integer.parseInt(arrQty[i]));
//			list.add(orderList);
//		}
		
		// 5. Connection 객체 반환
		close(con);
		
		// 6. 작업 결과 리턴
		return list;
	}

}
