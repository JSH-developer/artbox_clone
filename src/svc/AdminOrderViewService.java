package svc;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.AdminDAO;
import vo.OrdersBean;
import vo.OrdersDetailBean;
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
	
	
	public ArrayList<OrdersDetailBean> infoOrdersDetail(int orders_order_num) {
		ArrayList<OrdersDetailBean> ordersDetailBeans = null; 
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		ordersDetailBeans = adminDAO.toViewOrdersDetail(orders_order_num);
		
		close(con);
		
		return ordersDetailBeans;
	}

}
