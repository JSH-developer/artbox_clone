package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.List;

import dao.OrderDAO;

public class OrderDetailListService {

	public List getOrderDetailList(String id) {
		System.out.println("OrderDetailListService - getOrderDetailList()");
		
		Connection con = getConnection();
		OrderDAO orderDAO = OrderDAO.getInstance();
		orderDAO.setConnection(con);
		
		List list = orderDAO.getDetailList(id);
		
		close(con);
		
		// 6. 작업 결과 리턴
		return list;
	}

}
