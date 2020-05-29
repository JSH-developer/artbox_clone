package svc;

import java.sql.Connection;

import dao.MemberDAO;

import static db.jdbcUtil.*;

public class MemberLoginService {

	public boolean LoginSuccess(String id, String pw) {
		System.out.println("MemberLoginService - LoginSuccess");
		boolean LoginSuccess = false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		dao.LoginSuccess(id, pw);
		
		
		
		
		close(con);
		return LoginSuccess;
		
	}

	
}
