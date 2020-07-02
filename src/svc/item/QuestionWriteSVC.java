package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ItemDAO;
import vo.QuestionBean;

public class QuestionWriteSVC {

	public boolean registQuestion(QuestionBean questionBean) {
		boolean isWriteSucces = false;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		int insertCount = itemDAO.insertQuestion(questionBean);
		
		if(insertCount > 0) {
			commit(con);
			isWriteSucces = true;
		} else {
			rollback(con);
		}
		
		close(con);
		
		return isWriteSucces;
	}

}
