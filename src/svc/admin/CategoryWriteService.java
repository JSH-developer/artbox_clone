package svc.admin;

import java.sql.Connection;

import dao.AdminDAO;
import vo.CategoryBean;

import static db.jdbcUtil.*;

public class CategoryWriteService {
	
	public boolean registCategory(CategoryBean categoryBean) {
		boolean isRegist = false;
		
		Connection con =getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// category 테이블에 등록된 튜플 수 int값으로 반환
		int insertCount = adminDAO.regCategory(categoryBean);
		
		if(insertCount>0) {
			commit(con);
			isRegist=true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isRegist;
	}
	
	

}
