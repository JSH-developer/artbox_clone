package svc;

import java.sql.Connection;

import dao.AdminDAO;
import vo.OptionBean;

import static db.jdbcUtil.*;

public class OptionWriteService {
	
	public String makeOptionCode(String product_index) {
		String result="";
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		result = adminDAO.toMakeOptionCode(product_index);
		
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
