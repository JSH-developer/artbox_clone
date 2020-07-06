package svc;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.EventDAO;
import vo.ProductBean;

public class HomeService {

	public ArrayList<ProductBean> getNewList() {
		Connection con = getConnection();
		EventDAO homeDAO  = EventDAO.getInstance();
		homeDAO.setConnection(con);
		
		ArrayList<ProductBean> getNewList = homeDAO.selectNewList();
		
		close(con);
		
		return getNewList;
	}

}
