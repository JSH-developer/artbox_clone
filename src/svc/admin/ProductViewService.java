package svc.admin;

import java.sql.Connection;

import dao.AdminDAO;
import vo.ProductBean;

import static db.jdbcUtil.*;

public class ProductViewService {
	
	
	public ProductBean infoProduct(int product_num) {
		ProductBean productBean = null;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		productBean = adminDAO.toViewProduct(product_num);
		
		close(con);
		
		return productBean;
	}

}
