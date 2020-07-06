package svc.admin;

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

		// Member 테이블에서 index를 조회하여 MemberBean에 담아서 반환
		memberBean = adminDAO.toViewMember(num);
		
		close(con);
		
		return memberBean;
	}

}
