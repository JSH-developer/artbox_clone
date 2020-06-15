package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.CartDAO;

public class CartDeleteOneService {

	public static boolean deleteCart(String arrCart) {
		System.out.println("cartDeleteService - deleteCart()");
		
		boolean isCartDeleteSuccess = false; // 장바구니 추가 성공여부를 리턴
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 cartDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		CartDAO cartDAO = CartDAO.getInstance();
		
		// 3. cartDAO 객체에 Connection 객체 전달
		cartDAO.setConnection(con);
		
		String[] cartNumArr = arrCart.split(",");
		// 4. cartDAO 클래스의 deleteCart() 메서드를 호출
		//    파라미터 : cartidx
		//    리턴타입 : int
		int deleteCount = 0;
		int cart_num = 0;
		for(String i:cartNumArr) {
			deleteCount += cartDAO.deleteCart(Integer.parseInt(i));
		}
		
		// 5. 리턴받은 작업 결과 판별
		// => deleteCount 가 0보다 크면 commit() 실행, isCartDeleteSuccess 를 true 로 변경
		// => 아니면, rollback() 실행
		if(deleteCount > 0) {
			commit(con);
			isCartDeleteSuccess = true;
		} else {
			rollback(con);
		}
		
		// 6. Connection 객체 반환
		close(con);
		
		// 7. 작업 결과 리턴
		return isCartDeleteSuccess;
	}

}
