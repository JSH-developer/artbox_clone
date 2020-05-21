package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDao;
import vo.ActionForward;
import vo.ProductBean;

import static db.jdbcUtil.*;

import java.sql.Connection;

public class ItemDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ProductBean productBean = null;
		ActionForward fw = null;
		Connection con = getConnection();
		ItemDao itemDao = ItemDao.getDao();
		itemDao.setCon(con);
		itemDao.selectItemDetail();
		
		return null;
	}

}
