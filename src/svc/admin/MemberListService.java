package svc.admin;

import static db.jdbcUtil.close;
import static db.jdbcUtil.commit;
import static db.jdbcUtil.getConnection;
import static db.jdbcUtil.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.MemberBean;
import vo.ProductBean;

public class MemberListService {

	public int getListCount() {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		listCount = adminDAO.memberCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
		
	}

	public ArrayList<MemberBean> getMemberList(int page, int limit) {
		ArrayList<MemberBean> memberList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		memberList=adminDAO.toListMember(page, limit);
		
		if(!memberList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return memberList;
	}

}
