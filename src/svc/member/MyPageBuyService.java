package svc.member;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.List;

import dao.AdminDAO;
import vo.OrdersBean;

public class MyPageBuyService {

	public boolean changeBuyState(String orders_order_num) {
		boolean isChange = false;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		int changeCount = adminDAO.changeBuyState(orders_order_num);
		
		if(changeCount > 0) {
			isChange = true;
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isChange;
	}
	
	public boolean changeBuyPoint(int point,String id) {
		boolean isChange = false;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		int changeCount = adminDAO.changeBuyPoint(point, id);
		
		if(changeCount > 0) {
			isChange = true;
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isChange;
	}
	
	public boolean changeGrade(String id) {
		boolean isChange = false;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		int changeCount = adminDAO.changeGrade(id);
		
		if(changeCount > 0) {
			isChange = true;
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isChange;
	}


}
