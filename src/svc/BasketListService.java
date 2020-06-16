package svc;

import java.sql.Connection;
import java.util.List;

import dao.BasketDAO;

import static db.jdbcUtil.*;

public class BasketListService {
	
	public List getBasketList(String member_id) {
		System.out.println("BasketListService - getBasketList()");
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// 1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 2. DB 작업을 위한 basketDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		BasketDAO basketDAO = BasketDAO.getInstance();
		
		// 3. basketDAO 객체에 Connection 객체 전달
		basketDAO.setConnection(con);
		
		// 4. basketDAO 클래스의 selectBasketList() 메서드를 호출하여
		//    파라미터 : member_id
		//    리턴타입 : Vector
		List list = basketDAO.selectBasketList(member_id);
		
		// 5. Connection 객체 반환
		close(con);
		
		// 6. 작업 결과 리턴
		return list;
	}

}
