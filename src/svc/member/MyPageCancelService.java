package svc.member;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.List;

import dao.AdminDAO;
import vo.OrdersBean;

public class MyPageCancelService {

	public boolean changeCancelState(String orders_order_num) {
		boolean isChange = false;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		int changeCount = adminDAO.changeCancleState(orders_order_num);
		
		if(changeCount > 0) {
			isChange = true;
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return isChange;
	}
	
	public boolean changeCancelPoint(int point,String id) {
		boolean isChange = false;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		int changeCount = adminDAO.changeCanclePoint(point, id);
		
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
