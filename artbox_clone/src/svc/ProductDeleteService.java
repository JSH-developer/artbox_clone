package svc;

import java.sql.Connection;

import dao.AdminDAO;

import static db.jdbcUtil.*;

public class ProductDeleteService {

	public boolean deleteProduct(int num) {
		boolean isDelete = false;
		
		Connection con = getConnection(); 
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
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
