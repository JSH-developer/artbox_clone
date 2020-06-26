package svc.member;

import static db.jdbcUtil.*;

import java.sql.Connection;

import dao.MemberDAO;

public class MemberDeleteService {

	public void MemberDelete(String id) {
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		dao.memberDelete(id);
		
		commit(con);
		close(con);
	}

}
