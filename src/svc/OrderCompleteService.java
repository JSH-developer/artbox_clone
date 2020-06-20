package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.OrderDAO;
import vo.OrdersBean;
import vo.ReceiverBean;

public class OrderCompleteService {
	public boolean insertOrder(OrdersBean ordersbean, ReceiverBean receiverBean, List orderList, String id) {
		System.out.println("OrderCompleteService - insertOrder()");
		
		boolean isOrderInsertSuccess = false; // 장바구니 추가 성공여부를 리턴
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 basketDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		// 3. basketDAO 객체에 Connection 객체 전달
		orderDAO.setConnection(con);
		
		// 5. 리턴받은 작업 결과 판별
		// 	  check != 1 이면 장바구니에 새로 추가(없는 상품)
		//	  check == 1 이면 commit() 실행, isBasketAddSuccess 를 true 로 변경(있는 상품이므로 장바구니 수량만 변경)
		int isInsertCount = orderDAO.insertOrder(ordersbean);
		// OrderInsert 가 성공했을 때
		if(isInsertCount > 0) {
			isInsertCount = orderDAO.insertReceiver(receiverBean, id);
			// ReceiverInsert 가 성공했을 때
			if(isInsertCount > 0) {
				isInsertCount = orderDAO.insertDetail(orderList, id);
				// OrderDetailInsert 가 성공했을 때
				// => insertCount 가 0보다 크면 commit() 실행, isBasketAddSuccess 를 true 로 변경
				if(isInsertCount > 0) {
					commit(con);
					isOrderInsertSuccess = true;
				} else {
					// => 아니면, rollback() 실행
					rollback(con);
				}
			} else {
				// => 아니면, rollback() 실행
				rollback(con);
			}
		} else {
			// => 아니면, rollback() 실행
			rollback(con);
		}
		
		// 6. Connection 객체 반환
		close(con);
		
		// 7. 작업 결과 리턴
		return isOrderInsertSuccess;
	}
	
}
