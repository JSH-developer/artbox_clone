package svc.item;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.ItemDAO;
import vo.ProductBean;

public class OtherOptionListSVC {

	public ArrayList<ProductBean> getOtherOptionList(String product_option_code) {
		ArrayList<ProductBean> otherOptionList = null;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		otherOptionList = itemDAO.selectOtherOptionList(product_option_code);

		close(con);
		
		return otherOptionList;
	}

	
}
