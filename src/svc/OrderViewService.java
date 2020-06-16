package svc;

import java.sql.Connection;

import dao.AdminDAO;
import vo.OrdersBean;

import static db.jdbcUtil.*;

public class OrderViewService {
	
	
	public OrdersBean infoOrders(int orders_num) {
		OrdersBean ordersBean = null;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		ordersBean = adminDAO.toViewOrders(orders_num);
		
		close(con);
		
		return ordersBean;
	}

}
