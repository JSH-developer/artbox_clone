package svc.admin;

import java.sql.Connection;

import dao.AdminDAO;
import vo.OptionBean;

import static db.jdbcUtil.*;

public class OptionWriteService {
	
	public String productSelectList() {
		String result="";
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		// 옵션등록 페이지에서 상품의 리스트를 출력하기 위해 <option>상품1 ... </option> 상태로 String 출력
		result = adminDAO.toMakeProductSelect();
		
		if(result.length()>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return result;
	}
	
	public String makeOptionCode(String product_code_base) {
		String result="";
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		// DAO에서 만들어진 option코드를 String값으로 출력
		result = adminDAO.toMakeOptionCode(product_code_base);
		
		if(result.length()>0) {
			commit(con);
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return result;
	}

	
	public boolean registOption(OptionBean optionBean) {
		boolean isRegist=false;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		// Option에 등록 된 튜플 수만큼 int값 출력
		int insertCount = adminDAO.regOption(optionBean);
		if(insertCount>0) {
			commit(con);
			isRegist = true;
			
		}else {
			rollback(con);
		}
		
		
		close(con);
		
		return isRegist;
	}
	
}
