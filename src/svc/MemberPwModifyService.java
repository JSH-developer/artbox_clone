package svc;

import java.sql.Connection;

import dao.MemberDAO;
import static db.jdbcUtil.*;

public class MemberPwModifyService {

	public void MemberPwModify(String id, String newpw) {
		System.out.println("MemberPwModifyService - MemberPwModify");
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);	
		
		dao.pwModify(id,newpw);
		
		commit(con);
		close(con);
	}

}
