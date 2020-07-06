package svc.member;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.List;

import dao.AdminDAO;
import vo.OrdersBean;

public class MyPageReService {

	public List<OrdersBean> getMyRes(String id) {
		List<OrdersBean> myRes = null;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		myRes = adminDAO.getMyCancleOrders(id);
		// id값이 일치하는 OrdersBean만 ArrayList로 반환
		
		if(myRes != null) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return myRes;
	}

}
