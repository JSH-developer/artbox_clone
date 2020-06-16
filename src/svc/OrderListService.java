package svc;

import dao.AdminDAO;
import vo.OrdersBean;
import vo.ProductBean;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

public class OrderListService {
	
	public int getListCount() {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		listCount = adminDAO.orderCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
	}
	
	public ArrayList<OrdersBean> getOrderList(int page, int limit) {
		ArrayList<OrdersBean> orderList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		orderList=adminDAO.toListOrder(page, limit);
		
		if(!orderList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return orderList;
	}
	

}
