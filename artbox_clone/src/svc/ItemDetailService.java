package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ItemDAO;
import vo.ItemBean;

public class ItemDetailService {

	public ItemBean getArticle(int product_num) {
		ItemBean article = null;
		
		// 공통작업-1. static import 로 지정된 메서드 호출
		Connection con = getConnection();
		// 공통작업-2. DB 작업을 위한 ItemDAO 객체 생성 => 싱글톤 패턴으로 생성된 객체 가져오기
		ItemDAO itemDAO = ItemDAO.getInstance();
		// 공통작업-3. ItemDAO 객체에 Connection 객체 전달
		itemDAO.setConnection(con);
		// 4. 게시물 상세 내용 조회
		article = itemDAO.selectArticle(product_num);
		// 공통작업-5. Connection 객체 반환
		close(con);
		
		return article;
	}

}
