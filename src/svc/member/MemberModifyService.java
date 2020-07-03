package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.MemberDAO;
import vo.MemberBean;

public class MemberModifyService {

	public void MemberUpdate(MemberBean mb) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		dao.memberUpdate(mb);
		
		commit(con);
		close(con);
		
	}

}
