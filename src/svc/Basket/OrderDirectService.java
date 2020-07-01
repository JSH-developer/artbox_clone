package svc.Basket;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.OrderDAO;
import vo.ProductBean;
import vo.SelectOrderBean;

public class OrderDirectService {

	public List getOrderDirectList(String id, ProductBean productBean) {
		System.out.println("OrderDirectService - getOrderDirectList() - 바로 주문");
		
		Connection con = getConnection();
		
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		orderDAO.setConnection(con);
		
		// orderDAO 클래스의 OrderDirectList() 메서드를 호출하여
		//  파라미터 : id, productBean
		//  리턴타입 : List
		List list = new ArrayList();
		List<SelectOrderBean> basketList = new ArrayList<SelectOrderBean>();
		basketList = orderDAO.OrderDirectList(id, productBean);
		list.add(basketList);
		
		close(con);
		
		return list;
	}
	
}
