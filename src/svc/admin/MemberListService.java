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
		// member 테이블의 index 갯수 int값으로 반환
		listCount = adminDAO.memberCount();
		
		if(listCount>0) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return listCount;
		
	}
	
	// 오버로딩
	public int getListCount(String opt, String kwd) {
		int listCount=0;
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// opt와 kwd값이 존재할 시 값에 해당하는 member 테이블의 index 갯수 int값으로 반환
		listCount = adminDAO.memberCount(opt, kwd);
		
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
		// MembBean을 ArrayList에 담아서 반환
		memberList=adminDAO.toListMember(page, limit);
		
		if(!memberList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return memberList;
	}
	
	// 오버로딩
	public ArrayList<MemberBean> getMemberList(int page, int limit, String opt, String kwd) {
		ArrayList<MemberBean> memberList = null;
		
		
		Connection con = getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		// pt와 kwd값이 존재할 시 값에 해당하는 MembBean을 ArrayList에 담아서 반환
		memberList=adminDAO.toListMember(page, limit, opt, kwd);
		
		if(!memberList.isEmpty()) {
			commit(con);
		}else {
			rollback(con);
		}
		
		close(con);
		
		return memberList;
	}

}
