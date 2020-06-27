package svc.member;

import java.sql.Connection;

import dao.MemberDAO;
import vo.MemberBean;

import static db.jdbcUtil.*;

public class MemberJoinService {

	
	public boolean JoinSuccess(MemberBean bb) {
		System.out.println("MemberJoinService - JoinSuccess()");
		boolean joinSuccess = false;
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		System.out.println("bb null???? "+bb);
		int insertCount = dao.JoinInsert(bb);
		
//		System.out.println("insertcount > 0 ????"+insertCount);
		
		
		if(insertCount > 0 ) {
			commit(con);
			joinSuccess = true;
		}else {
			rollback(con);
		}
		
		close(con);
		
		return joinSuccess;
		
	}

	
}
