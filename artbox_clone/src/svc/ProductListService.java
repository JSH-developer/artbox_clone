package svc;

import dao.AdminDAO;
import vo.ProductBean;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

public class ProductListService {
	
	public int getListCount() {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		listCount = adminDAO.productCount();
		
		close(con);
		
		return listCount;
	}
	
	public ArrayList<ProductBean> getProductList(int page, int limit) {
		ArrayList<ProductBean> productList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		productList=adminDAO.toListProduct(page, limit);
		
		close(con);
		
		return productList;
	}
	

}
