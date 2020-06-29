package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;

public class ReviewListSVC {
	
	
	public ArrayList<ProductBean> getReviewList(String id) {
		System.out.println("getReviewList");
		ArrayList<ProductBean> reviewList = null; 
		
		// 공통작업
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		reviewList = itemDAO.selectReviewList(id);

		close(con);
		
		return reviewList;
	}
	

	
	
}
