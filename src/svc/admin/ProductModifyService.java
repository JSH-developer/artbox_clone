package svc.admin;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;

import dao.AdminDAO;
import vo.ProductBean;

public class ProductModifyService {

	public boolean modifyProduct(ProductBean productBean) {
		boolean isUpdateSuccess = false;
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		Connection con = getConnection();
		adminDAO.setConnection(con);
		
		// 상품으 수정되면 1(수정된 튜플 수)이 반환된다.
		int updateCount = adminDAO.modifyProduct(productBean);
		
		if(updateCount>0) {
			commit(con);
			isUpdateSuccess=true;
		}else {
			rollback(con);
		}
		close(con);
		
		return isUpdateSuccess;
	}
	
	
}
