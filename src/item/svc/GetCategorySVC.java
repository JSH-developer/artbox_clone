package item.svc;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.ItemDAO;
import vo.CategoryBean;

public class GetCategorySVC {

	public String getCategorySub(String product_category_code) {
		String category_sub = null;
		
		Connection con = getConnection();
		ItemDAO itemDAO = ItemDAO.getInstance();
		itemDAO.setConnection(con);
		
		CategoryBean categoryBean = itemDAO.getCategory(product_category_code);
		category_sub = categoryBean.getCategory_sub();
		
		close(con);
		
		return category_sub;
	}

}
