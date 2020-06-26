package svc.member;

import java.sql.Connection;

import dao.MemberDAO;

import static db.jdbcUtil.*;

public class MemberCheckService {
	
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

	public boolean profileCheck(String id, String pw) {
		boolean pwcheck = false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		int checkSuccess = dao.idpwSuccess(id, pw);
		if(checkSuccess == 1) {
			
			pwcheck = true; // 패스워드 일치
		}
		
		close(con);
		return pwcheck;
	}



}
