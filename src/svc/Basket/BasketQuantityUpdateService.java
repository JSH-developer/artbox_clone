package svc.Basket;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.BasketDAO;

public class BasketQuantityUpdateService {

	public static boolean updateBasket(int cartidx, int quantity) {
		System.out.println("BasketUpdateService - updateBasket()");
		
		boolean isBasketUpdateSuccess = false; // 장바구니 추가 성공여부를 리턴
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 cartDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		BasketDAO cartDAO = BasketDAO.getInstance();
		
		// 3. cartDAO 객체에 Connection 객체 전달
		cartDAO.setConnection(con);
		
		// 4. cartDAO 클래스의 updateQuantity() 메서드를 호출
		//    파라미터 : 수량(quantity), 장바구니 인덱스번호(cartidx)
		//    리턴타입 : int
		int updateCount = cartDAO.updateQuantity(quantity, cartidx);
		
		// 5. 리턴받은 작업 결과 판별
		// => updateCount 가 0보다 크면 commit() 실행, isBasketUpdateSuccess 를 true 로 변경
		// => 아니면, rollback() 실행
		if(updateCount > 0) {
			commit(con);
			isBasketUpdateSuccess = true;
		} else {
			rollback(con);
		}
		
		// 6. Connection 객체 반환
		close(con);
		
		// 7. 작업 결과 리턴
		return isBasketUpdateSuccess;
	}

}
