package svc.item;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;

import dao.ItemDAO;

public class ReviewAnswerSVC {

	public boolean registAnswer(int reNum, String reName, String reContent) {
		boolean isWriteSucces = false;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		int updateCount = itemDAO.updateReviewAnswer(reNum, reName, reContent);

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
