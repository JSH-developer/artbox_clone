package svc.admin;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.ProductBean;

public class BestItemService {
	
	public ArrayList<ProductBean> getBestList() {
		ArrayList<ProductBean> bestList = null;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// 베스트 상품 10 ProductBean 10개를 ArrayList에 담아서 반환
		bestList=adminDAO.toBestProduct();
		
		if(!bestList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return bestList;
	}

}
