package item.svc;

import java.sql.Connection;
import static db.jdbcUtil.*;

import dao.ItemDAO;


public class CategoryMajorCountSVC {
	
	public int getCount(String majorCategory) {
		int count = 0;
		Connection con = getConnection();
		ItemDAO dao = ItemDAO.getInstance();
		dao.setConnection(con);
		count = dao.getMajorCount(majorCategory);
		
		return count;
	}

}
