package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ItemDAO;
import vo.ReviewBean;

public class ReviewWriteSVC {

	public boolean registReview(ReviewBean reviewBean) {
		boolean isWriteSucces = false;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		int insertCount = itemDAO.insertReview(reviewBean);
		
		if(insertCount > 0) {
			commit(con);
			isWriteSucces = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isWriteSucces;
	}

	public int checkReview(ReviewBean reviewBean) {
		int isWrite;

		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		isWrite = itemDAO.insertCheckReview(reviewBean);
		
		return isWrite;
	}

}
