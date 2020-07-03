package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.MemberDAO;
import dao.OrderDAO;
import vo.ReceiverBean;

public class ReceiverSelectService {

	public List<ReceiverBean> ReceiverSelect(String id) {
		
		Connection con = getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		List list = dao.getBasicReceiverList(id);
		
		close(con);
	
		return list;
	}

}
