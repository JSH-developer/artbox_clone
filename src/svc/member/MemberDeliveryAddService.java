package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;

//import dao.receiverDAO;
import vo.ReceiverBean;

public class MemberDeliveryAddService {

	public void MemberDeliveryAdd(ReceiverBean rb) {
		System.out.println("MemberDeliveryAddService - MemberDeliveryAdd");
		
		Connection con = getConnection();
//		receiverDAO dao = receiverDAO.getInstance();
//		dao.setConnection(con);	
//		
//		dao.insertReceiver(rb);
		
		commit(con);
		close(con);
	}
	
	
	

}
