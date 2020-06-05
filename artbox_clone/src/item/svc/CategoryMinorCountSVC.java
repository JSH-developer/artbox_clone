package item.svc;

import java.sql.Connection;

import dao.ItemDAO;

public class CategoryMinorCountSVC {
	public int getCount(String minorCategory) {
		int count = 0;
		Connection con = null;
		ItemDAO dao = ItemDAO.getInstance();
		dao.setConnection(con);
		count = dao.getMinorCount(minorCategory);
		
		return count;
	}

}
