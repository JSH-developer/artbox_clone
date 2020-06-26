package svc.admin;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;

import dao.AdminDAO;

public class AdminChangeStateService {

	public boolean changeState(int state, int num) {
		boolean isChange = false;
		
		Connection con = getConnection(); 
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		int changeCount = adminDAO.changeMemState(state, num);
		
		if(changeCount>0) {
			commit(con);
			isChange = true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isChange;
	}
	
	
}
