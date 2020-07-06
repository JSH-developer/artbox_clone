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
		// 주문번호와 일치하는 수정된 튜플의 수를 int형으로 반환
		
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
		// 포인트 업데이트 및 멤버 포인트 수정된 여부 int값으로 반환
		
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
