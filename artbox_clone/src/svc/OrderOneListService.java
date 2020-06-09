package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import vo.SelectOrderBean;

public class OrderOneListService {

	public List getOrderOneList(String member_id, String arrCart) {
		System.out.println("OrderOneListService - getOrderOneList()");
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 orderDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		// 3. orderDAO 객체에 Connection 객체 전달
		orderDAO.setConnection(con);
		
		String[] cartNumArr = arrCart.split(",");
		// 4. orderDAO 클래스의 selectOrderList() 메서드를 호출하여
		//    파라미터 : member_id
		//    리턴타입 : List
		
		List list = new ArrayList();
		for(String i:cartNumArr) {
			ArrayList<SelectOrderBean> cartList = new ArrayList<SelectOrderBean>();
			cartList = orderDAO.OrderOneList(member_id, Integer.parseInt(i));
			list.add(cartList);
		}
		
		
/*
		// 4. orderDAO 클래스의 selectOrderList() 메서드를 호출하여
		//    파라미터 : member_id
		//    리턴타입 : List
		List list = orderDAO.OrderOneList(member_id, product_num);
 */

		// 5. Connection 객체 반환
		close(con);
		
		// 6. 작업 결과 리턴
		return list;
	}

}
