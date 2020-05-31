package svc;

import vo.EventBean;
import static db.jdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.EventDAO;


public class EventService {

	public boolean registEvent(EventBean eventBean) {
		boolean writeSuccess = false;

		Connection con = getConnection();
		
		EventDAO eventDAO = EventDAO.getInstance();
		eventDAO.setConnection(con);
		
		int isSuccess = eventDAO.registEvent(eventBean);
		
		if(isSuccess>0) {
			writeSuccess = true;
			commit(con);
		}else {
			rollback(con);
		}
		
		
		return writeSuccess;
	}
	
	// 이벤트 게시물 카운트
	public int getListCount() {
		System.out.println("EventService - getListCount");
		int listCount = 0;
		
		Connection con = getConnection();
		EventDAO boardDAO = EventDAO.getInstance();
		boardDAO.setConnection(con);
		
		listCount = boardDAO.selectListCount(); // create함
		
		close(con);
		
		return listCount;
	}

	// 이벤트 리스트 가져오기
	public ArrayList<EventBean> getArticleList(int page, int limit) {
		
		ArrayList<EventBean> articleList = null;
		
		Connection con = getConnection();
		EventDAO eventDAO = EventDAO.getInstance();
		eventDAO.setConnection(con);
		
		articleList = eventDAO.selectArticleList(page,limit);
		
		close(con);
		
		return articleList;
	}

}
