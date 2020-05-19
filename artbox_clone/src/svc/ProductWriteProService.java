package svc;

import java.sql.Connection;

import dao.AdminDAO;
import vo.ProductBean;

import static db.jdbcUtil.*;

public class ProductWriteProService {
	
	
	
	public boolean registProduct(ProductBean pb) {
		boolean isRegistSuccess = false;
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		Connection con = getConnection();
		adminDAO.setConnection(con);
		
		int registCount = adminDAO.regProduct(pb);
		
		if(registCount>0) {
			commit(con);
			isRegistSuccess=true;
		}else {
			rollback(con);
		}
		close(con);
		
		return isRegistSuccess;
	}
	
	

}
