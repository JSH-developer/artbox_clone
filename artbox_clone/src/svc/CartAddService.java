package svc;

import java.sql.Connection;

import dao.CartDAO;
import vo.CartBean;

import static db.jdbcUtil.*;

public class CartAddService {
	
	public void addCart(CartBean cartBean) {
		System.out.println("CartListService - addCart()");
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 cartDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		CartDAO cartDAO = CartDAO.getInstance();
		
		// 3. cartDAO 객체에 Connection 객체 전달
		cartDAO.setConnection(con);
		
		// 4. cartDAO 클래스의 insertCart() 메서드를 호출
		//    파라미터 : cartBean
		cartDAO.insertCart(cartBean);
		
		// 5. Connection 객체 반환
		close(con);
		
	}

}
