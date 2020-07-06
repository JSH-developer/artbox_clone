package svc.item;

import static db.jdbcUtil.close;
import static db.jdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;
import vo.ReviewBean;

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

	public ArrayList<ReviewBean> getItemReviewModList(String id, int page, int limit) {
		ArrayList<ReviewBean> itemReviewModList = null; 
		
		// 공통작업
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		itemReviewModList = itemDAO.selectItemReviewModList(id, page, limit);

		close(con);
		
		return itemReviewModList;
	}

	public int getItemReviewModListCount(String id) {
		int listCount = 0;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		listCount = itemDAO.selectItemReviewModListCount(id);
		
		close(con);
		
		return listCount;
	}
	
}
