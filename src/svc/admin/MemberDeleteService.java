package svc.admin;

import java.sql.Connection;

import dao.AdminDAO;

import static db.jdbcUtil.*;

public class MemberDeleteService {

	public boolean deleteMember(int num) {
		boolean isDelete = false;
		
		Connection con = getConnection(); 
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		int deleteCount = adminDAO.deleteMember(num);
		
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
