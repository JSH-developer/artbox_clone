package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ItemDAO;
import vo.ReviewBean;

public class ReviewUpdateSVC {

	public boolean updateReview(ReviewBean reviewBean) {
		boolean isWriteSucces = false;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		int updateCount = itemDAO.updateReview(reviewBean);
		
		if(updateCount > 0) {
			commit(con);
			isWriteSucces = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isWriteSucces;
	}

}
