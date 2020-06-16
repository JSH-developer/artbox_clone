package svc;

import java.sql.Connection;

import dao.AdminDAO;
import vo.OrdersBean;
import vo.ReceiverBean;

import static db.jdbcUtil.*;

public class AdminOrderViewService {
	
	
	public OrdersBean infoOrders(int orders_num) {
		OrdersBean ordersBean = null;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		ordersBean = adminDAO.toViewOrders(orders_num);
		
		close(con);
		
		return ordersBean;
	}

	public ReceiverBean infoReceiver(int orders_order_num) {
		ReceiverBean receiverBean = null;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		receiverBean = adminDAO.toViewReceiver(orders_order_num);
		
		close(con);
		
		return receiverBean;
	}

}