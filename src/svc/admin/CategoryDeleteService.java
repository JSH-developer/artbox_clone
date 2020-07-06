package svc.admin;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;

import dao.AdminDAO;

public class CategoryDeleteService {

	public boolean deleteCategory(int num) {
		boolean isDelete = false;
		
		Connection con = getConnection(); 
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// category 테이블에서 삭제된 튜플 수 int 값으로 반환
		int deleteCount = adminDAO.deleteCategory(num);
		
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
