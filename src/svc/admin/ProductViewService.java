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

		// 상품인덱스로 조회한 상품정보는 ProductBean에 담겨서 반환 됨
		productBean = adminDAO.toViewProduct(product_num);
		
		close(con);
		
		return productBean;
	}

	// 오버로딩
	public ProductBean infoProduct(String product_code) {
		ProductBean productBean = null;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		// 상품코드로 조회한 상품정보는 ProductBean에 담겨서 반환 됨
		productBean = adminDAO.toViewProduct(product_code);
		
		close(con);
		
		return productBean;
	}
	
}
