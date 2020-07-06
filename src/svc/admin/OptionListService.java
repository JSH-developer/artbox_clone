package svc.admin;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.OptionBean;

public class OptionListService {
	
	public int getListCount() {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// option 테이블의 index 갯수를 int값으로 출력
		listCount = adminDAO.optionCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
	}	
	
	public ArrayList<OptionBean> getOptionList(int page, int limit) {
		ArrayList<OptionBean> optionList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// OptionBean을 ArrayList에 담아서 출력
		optionList=adminDAO.toListOption(page, limit);
		
		if(!optionList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return optionList;
	}
	
}
