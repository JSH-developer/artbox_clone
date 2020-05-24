package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.CouponDAO;
import vo.CouponBean;

public class CouponService {

	public boolean registCoupon(CouponBean couponBean) {
		System.out.println("BoardWriteProService - registArticle()");
		
		boolean isRegistSuccess = false; // 글 등록 성공 여부를 리턴할 변수
		
		// DB 작업을 위한 준비 => Connection 객체, DAO 객체, DAO 객체의 메서드 호출
		// jdbcUtil 에 static 붙임
		// 1. DB 작업에 필요한 Connection 객체 가져오기
//		Connection con = jdbcUtil.getConnection(); // import가 되어야만 쓸수 있음
		Connection con = getConnection(); 		// import static db.jdbcUtil.*; 으로 바꾸면 그냥 쓸수 있음
		
		// 2. DB 작업을 위한 BoardDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		CouponDAO couponDAO = CouponDAO.getInstance();
		
		// 3. BoardDAO 객체에 Connection 객체 전달
		couponDAO.setConnection(con);
		
		// 4. BoardDAO 객체의 insertArticle() 메서드를 호출하여 글 등록 처리
		// => 파라미터 : BoardBean 객체, 리턴타입 : int(insertCount)
		int insertCount = couponDAO.insertArticle(couponBean);
		
		// 5. 리턴받은 작업결과 판별
		// => insertCount가 0보다 크면 commit() 실행, isWriteSuccess를 true로 변경
		// => 아니면, rollback()실행
		if(insertCount>0) {
			commit(con);
			isRegistSuccess = true;
		}else {
			rollback(con);
		}
		
		
		// 6. Connection 객체 반환
		close(con);
		
		
		
		return isRegistSuccess;
	}

	
	
}