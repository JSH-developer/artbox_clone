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
	
	public ArrayList<CategoryBean> getCateogryList(){
		ArrayList<CategoryBean> categoryList = new ArrayList<CategoryBean>();
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		categoryList=adminDAO.toListCategory();
		
		if(!categoryList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
				
		return categoryList;
	}
	

}
