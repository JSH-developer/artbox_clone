package svc.item;

import java.sql.Connection;
import java.util.ArrayList;
import static db.jdbcUtil.*;

import dao.ItemDAO;
import vo.ProductBean;

public class CategoryMinorLinkSVC {
	
	public ArrayList<ProductBean> minorLinkSVC(String minorCategory){
		//DAO 호출 및 초기화
		ArrayList<ProductBean> minorLink = new ArrayList<ProductBean>();
		ItemDAO itemDao = ItemDAO.getInstance();
		Connection con = getConnection();
		itemDao.setConnection(con);
		
		//DAO 에서 상품목록 가져오기
		minorLink = itemDao.selectMinorLink(minorCategory);
		return minorLink; 
		
	}

}
