package svc;

import java.sql.Connection;

import dao.CartDAO;
import vo.CartBean;

import static db.jdbcUtil.*;

public class CartAddService {
	
	public boolean addCart(CartBean cartBean) {
		System.out.println("CartAddService - addCart()");
		
		boolean isCartAddSuccess = false; // 장바구니 추가 성공여부를 리턴
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 cartDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		CartDAO cartDAO = CartDAO.getInstance();
		
		// 3. cartDAO 객체에 Connection 객체 전달
		cartDAO.setConnection(con);
		
		// 4. cartDAO 클래스의 checkItems() 메서드를 호출(장바구니에 있는 상품인지 아닌지)
		//    파라미터 : cartBean
		//	  리턴타입 : int
		int check = cartDAO.checkItems(cartBean);
		
		// 5. 리턴받은 작업 결과 판별
		// 	  check != 1 이면 장바구니에 새로 추가(없는 상품)
		//	  check == 1 이면 commit() 실행, isCartAddSuccess 를 true 로 변경(있는 상품이므로 장바구니 수량만 변경)
		if(check != 1) {
			int isInsertCount = cartDAO.insertCart(cartBean);
			// => insertCount 가 0보다 크면 commit() 실행, isCartAddSuccess 를 true 로 변경
			if(isInsertCount > 0) {
				commit(con);
				isCartAddSuccess = true;
			} else {
				// => 아니면, rollback() 실행
				rollback(con);
			}
		} else if(check == 1) {
			commit(con);
			isCartAddSuccess = true;
		}
		
		// 6. Connection 객체 반환
		close(con);
		
		// 7. 작업 결과 리턴
		return isCartAddSuccess;
	}

}
