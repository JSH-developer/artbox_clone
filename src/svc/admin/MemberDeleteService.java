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
		// member테이블에서 삭제된 튜플 수 int값 으로 반환
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
