package svc;

import java.sql.Connection;

import dao.AdminDAO;
import vo.ProductBean;

import static db.jdbcUtil.*;

public class ProductWriteService {
	
	public String categorySelectList() {
		String result="";
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		result = adminDAO.toMakeCategorySelect();
		
		if(result.length()>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return result;
	}
	
	public String optionSelectList() {
		String result="";
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		result = adminDAO.toMakeOptionSelect();
		
		if(result.length()>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return result;
	}
	
	public int countProduct() {
		int num=1;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		num += adminDAO.productCount();
		
		if(num>1) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return num;
	}
	
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
