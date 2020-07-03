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

	public void rModifyPro(ReceiverBean rb) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		dao.rModifyUpdate(rb);
		
		commit(con);
		close(con);
	}

	public void ReceiverDelete(int receiverNum) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		dao.ReceiverDelete(receiverNum);
		
		commit(con);
		close(con);
	}

	public void ReceiverBasic(int receiverNum, String id) {
		int basic = 0;
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		dao.ReceiverBasic(receiverNum, id);
		
		commit(con);
		close(con);
		
	}

}
