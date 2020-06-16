package svc;

import static db.jdbcUtil.close;
import static db.jdbcUtil.getConnection;

import java.sql.Connection;

import dao.AdminDAO;
import vo.MemberBean;
import vo.ProductBean;

public class MemberViewService {

	public MemberBean infoMember(int num) {
		MemberBean memberBean = null;
		
		Connection con = getConnection();
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);

		memberBean = adminDAO.toViewMember(num);
		
		close(con);
		
		return memberBean;
	}

}
