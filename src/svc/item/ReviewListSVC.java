package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;

public class ReviewListSVC {
	
	
	public ArrayList<ProductBean> getReviewList(String id,int page, int limit) {
		System.out.println("getReviewList");
		ArrayList<ProductBean> reviewList = null; 
		
		// 공통작업
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		reviewList = itemDAO.selectReviewList(id, page, limit);

		close(con);
		
		return reviewList;
	}

	public int getListCount(String id) {
		System.out.println("ReviewListSVC - getListCount()");
		int listCount = 0;
		
		// 공통작업-1. DB 작업에 필요한 Connection 객체 가져오기
		Connection con = getConnection();
		
		// 공통작업-2. DB 작업을 위한 BoardDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		ItemDAO itemDAO = ItemDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달
		itemDAO.setConnection(con);
		
		// 4. BoardDAO 클래스의 selectListCount() 메서드를 호출하여 전체 게시물 수 가져오기
		listCount = itemDAO.selectReviewListCount(id);
		
		// 공통작업-5. Connection 객체 반환
		close(con);
		
		// 6. 작업 결과 리턴
		return listCount;
	}

	
}
