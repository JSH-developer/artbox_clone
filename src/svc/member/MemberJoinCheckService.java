package svc.member;

import java.sql.Connection;

import dao.MemberDAO;

import static db.jdbcUtil.*;

public class MemberJoinCheckService {
	
	public boolean idcheckSuccess(String id) {
		boolean idcheckSuccess = false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		System.out.println("service - id값 왔냐????"+id);
		idcheckSuccess =  dao.idcheck(id);
		
		
		
		close(con);
		
		return idcheckSuccess;
	}



}
