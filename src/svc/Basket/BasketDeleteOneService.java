package svc.Basket;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.BasketDAO;

public class BasketDeleteOneService {

	public static boolean deleteBasket(String arrBasket) { // 여러개 삭제
		System.out.println("basketDeleteService - deleteBasket()");
		
		boolean isBasketDeleteSuccess = false; // 장바구니 삭제 성공여부를 리턴
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 basketDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		BasketDAO basketDAO = BasketDAO.getInstance();
		
		// 3. basketDAO 객체에 Connection 객체 전달
		basketDAO.setConnection(con);
		
		String[] basketNumArr = arrBasket.split(",");
		// 4. basketDAO 클래스의 deleteBasket() 메서드를 호출
		//    파라미터 : basketIdx
		//    리턴타입 : int
		int deleteCount = 0;
		for(String i:basketNumArr) {
			deleteCount += basketDAO.deleteBasket(Integer.parseInt(i));
		}
		
		// 5. 리턴받은 작업 결과 판별
		// => deleteCount 가 0보다 크면 commit() 실행, isBasketDeleteSuccess 를 true 로 변경
		// => 아니면, rollback() 실행
		if(deleteCount > 0) {
			commit(con);
			isBasketDeleteSuccess = true;
		} else {
			rollback(con);
		}
		
		// 6. Connection 객체 반환
		close(con);
		
		// 7. 작업 결과 리턴
		return isBasketDeleteSuccess;
	}
	
	public static boolean deleteBasket(int basketIdx) { // 하나 삭제
		System.out.println("basketDeleteService - deleteBasket()");
		
		boolean isBasketDeleteSuccess = false; // 장바구니 삭제 성공여부를 리턴
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 basketDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		BasketDAO basketDAO = BasketDAO.getInstance();
		
		// 3. basketDAO 객체에 Connection 객체 전달
		basketDAO.setConnection(con);
		
		// 4. basketDAO 클래스의 deleteBasket() 메서드를 호출
		//    파라미터 : basketIdx
		//    리턴타입 : int
		int deleteCount = 0;
		deleteCount = basketDAO.deleteBasket(basketIdx);
		
		// 5. 리턴받은 작업 결과 판별
		// => deleteCount 가 0보다 크면 commit() 실행, isBasketDeleteSuccess 를 true 로 변경
		// => 아니면, rollback() 실행
		if(deleteCount > 0) {
			commit(con);
			isBasketDeleteSuccess = true;
		} else {
			rollback(con);
		}
		
		// 6. Connection 객체 반환
		close(con);
		
		// 7. 작업 결과 리턴
		return isBasketDeleteSuccess;
	}

}
