package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;

public class ItemReviewListSVC {
	
	
	public ArrayList<ProductBean> getItemReviewList(String id,int page, int limit) {
		ArrayList<ProductBean> itmeReviewList = null; 
		
		// 공통작업
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		itmeReviewList = itemDAO.selectItemReviewList(id, page, limit);

		close(con);
		
		return itmeReviewList;
	}

	public int getItemReviewListCount(String id) {
		int listCount = 0;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		listCount = itemDAO.selectItemReviewListCount(id);
		
		close(con);
		
		return listCount;
	}
	
}
