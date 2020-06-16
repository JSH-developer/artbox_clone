package svc;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;

import dao.AdminDAO;

public class OptionDeleteService {

	public boolean deleteOption(int num) {
		boolean isDelete = false;
		
		Connection con = getConnection(); 
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		int deleteCount = adminDAO.deleteOption(num);
		
		if(deleteCount>0) {
			commit(con);
			isDelete = true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isDelete;
	}

}
