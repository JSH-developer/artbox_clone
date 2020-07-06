package svc.item;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;

import dao.ItemDAO;

public class ReviewDeleteSVC {

	public boolean deleteReview(String id, int review_num) {
		boolean isDeleteSucces = false;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		int deleteCount = itemDAO.deleteReview(id, review_num);
		
		if(deleteCount > 0) {
			commit(con);
			isDeleteSucces = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isDeleteSucces;
	}

}
