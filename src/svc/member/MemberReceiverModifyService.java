package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.MemberDAO;
import vo.ReceiverBean;

public class MemberReceiverModifyService {

	public ReceiverBean MemberReceiverModify(int receiverNum) {
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		ReceiverBean rb = dao.ReceiverModify(receiverNum);
		
		close(con);
		
		return rb;
		
	}

}
