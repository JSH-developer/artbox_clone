package svc.member;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;

import java.sql.Connection;

import dao.MemberDAO;
import vo.MemberBean;

public class MemberFindId {

	public String findId(MemberBean bb) {
		
		Connection con = getConnection();
		MemberDAO dao = MemberDAO.getInstance();
		dao.setConnection(con);
		
		String id = dao.findId(bb);
		
		close(con);
		
		
		return id;
		
	}

}
