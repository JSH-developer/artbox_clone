package svc.admin;

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
		
		// toMakeCategorySelect는 출력값이 <option>카테고리1 ... </option>과 같이 출력되므로 String 값으로 받는다.
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
		
		// toMakeOptionSelect는 출력값이 <option>옵션1 ... </option>과 같이 출력되므로 String 값으로 받는다.
		result = adminDAO.toMakeOptionSelect();
		
		if(result.length()>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return result;
	}
	
	public String countProduct() {
		String num="";
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		// 옵션코드 부여용 함수로  001, 010, 099와 같은 String 형태로 반환된다. 
		num += adminDAO.productCount2();
		
		if(num.length()>0) {
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
		
		// regProduct는 상품이 등록된 갯수만큼 int값을 반환한다.
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
