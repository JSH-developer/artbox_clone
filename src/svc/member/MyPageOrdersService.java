package svc.member;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.List;

import dao.AdminDAO;
import dao.MemberDAO;
import vo.MemberBean;
import vo.OrdersBean;

public class MyPageOrdersService {

	public List<OrdersBean> getMyOrders(String id) {
		List<OrdersBean> myOrders = null;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		myOrders = adminDAO.getMyOrders(id);
		
		if(myOrders != null) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return myOrders;
	}

	public MemberBean myPoint(String id) {
		MemberBean bb = new MemberBean();
		Connection con = getConnection();
		
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		bb = memberDAO.myName(id);
		
		close(con);
		
		return bb;
	}

	public int orderCount(String id) {
		int orderCount = 0;
		Connection con = getConnection();
		MemberDAO memberDAO = MemberDAO.getInstance();
		memberDAO.setConnection(con);
		
		orderCount = memberDAO.orderCount(id);
		
		return orderCount;
	}

}
