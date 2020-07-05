package svc.admin;

import java.sql.Connection;

import dao.AdminDAO;

import static db.jdbcUtil.*;

public class ProductDeleteService {

	public boolean deleteProduct(int num) {
		boolean isDelete = false;
		
		Connection con = getConnection(); 
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		// Product 테이블에서 삭제한 튜플 수를 int값으로 출력
		int deleteCount = adminDAO.deleteProduct(num);
		
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
