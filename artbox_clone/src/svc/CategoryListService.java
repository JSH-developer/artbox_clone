package svc;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.CategoryBean;

public class CategoryListService {
	
	public int getListCount() {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		listCount = adminDAO.categoryCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
	}
	
	public ArrayList<CategoryBean> getCateogryList(int page, int limit){
		ArrayList<CategoryBean> categoryList = new ArrayList<CategoryBean>();
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		categoryList=adminDAO.toListCategory(page, limit);
		
		if(!categoryList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
				
		return categoryList;
	}
	

}
