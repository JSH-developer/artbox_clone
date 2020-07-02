package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;

public class SearchSVC {
	
	public ArrayList<ProductBean> search(String kwd){
		ArrayList<ProductBean> product = new ArrayList<ProductBean>();
		Connection con = getConnection();
		ItemDAO dao = ItemDAO.getInstance();
		dao.setConnection(con);
		product = dao.search(kwd);		
		return product;
	}

}