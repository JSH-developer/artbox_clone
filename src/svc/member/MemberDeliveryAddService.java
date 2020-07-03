package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.OrderDAO;
//import dao.receiverDAO;
import vo.ReceiverBean;

public class MemberDeliveryAddService {

	public int MemberDeliveryAdd(ReceiverBean rb) {
		System.out.println("MemberDeliveryAddService - MemberDeliveryAdd");
		
		Connection con = getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);	
		
		int success = dao.insertReceiver(rb);
		
		commit(con);
		close(con);
		return success;
	}
	
	
	

}
