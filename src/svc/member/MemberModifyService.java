package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.MemberDAO;
import vo.MemberBean;

public class MemberModifyService {

	public int MemberUpdate(MemberBean mb) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		int success = dao.memberUpdate(mb);
		
		commit(con);
		close(con);
		
		return success;
	}

}
