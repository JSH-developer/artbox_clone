package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;

public class CategoryMajorLinkSVC {

	

	public ArrayList<ProductBean> linkSVC(String majorCategory) {
		//DAO 호출 및 초기화 
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		ItemDAO dao = ItemDAO.getInstance();
		Connection con = getConnection();
		dao.setConnection(con);
		
		//DAO 에서 상품목록 가져오기 
		listProduct = dao.selectMajorLink(majorCategory);
		return listProduct;
	}
}