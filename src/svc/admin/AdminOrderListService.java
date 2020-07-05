package svc.admin;

import dao.AdminDAO;
import vo.OrdersBean;
import vo.ProductBean;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

public class AdminOrderListService {
	
	public int getListCount() {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		//orders테이블의 index 갯수를 int값으로 반환
		listCount = adminDAO.orderCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
	}
	
	// 오버로딩
	public int getListCount(int state) {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// state 값을 기준으로 일치하는 orders테이블의 index 갯수를 int값으로 반환
		listCount = adminDAO.orderCount(state);
		
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
		// OrdersBean을 ArrayList에 담아서 반환
		orderList=adminDAO.toListOrder(page, limit);
		
		if(!orderList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return orderList;
	}
	
	// 오버로딩
	public ArrayList<OrdersBean> getOrderList(int page, int limit, int state) {
		ArrayList<OrdersBean> orderList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// state 값을 기준으로 일치하는 OrdersBean을 ArrayList에 담아서 반환
		orderList=adminDAO.toListOrder(page, limit, state);
		
		if(!orderList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return orderList;
	}
	

}
