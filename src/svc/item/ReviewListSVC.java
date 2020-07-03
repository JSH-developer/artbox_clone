package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ReviewBean;

public class ReviewListSVC {

	public ArrayList<ReviewBean> getReviewList(int porduct_num, int page, int limit) {
		
		ArrayList<ReviewBean> articleList = null;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		articleList = itemDAO.selectReviewList(porduct_num, page, limit);
		
		close(con);
		
		return articleList;
	}

	public int getReviewListCount(int porduct_num) {
		int listCount = 0;

		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		listCount = itemDAO.selecReviewtListCount(porduct_num);
		
		close(con);
		
		return listCount;
	}

}
