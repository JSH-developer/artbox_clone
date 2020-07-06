package svc.admin;

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
		// product테이블의 index 갯수를 int형으로 반환
		listCount = adminDAO.productCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
	}
	
	//오버로딩
	public int getListCount(String opt, String kwd) {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// product테이블의 opt와 kwd를 기준으로 일치하는 index 갯수를   int형으로 반환
		listCount = adminDAO.productCount(opt, kwd);
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
	}
	
	public ArrayList<ProductBean> getProductList(int page, int limit) {
		ArrayList<ProductBean> productList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// ProductBean들을 ArrayList에 담아서 출력
		productList=adminDAO.toListProduct(page, limit);
		
		if(!productList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return productList;
	}
	
	// 오버로딩
	public ArrayList<ProductBean> getProductList(int page, int limit, String opt, String kwd) {
		ArrayList<ProductBean> productList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		//  opt와 kwd를 기준으로 일치하는 ProductBean들을 ArrayList에 담아서 출력
		productList=adminDAO.toListProduct(page, limit, opt, kwd);
		
		if(!productList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return productList;
	}
	

}
