package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.EventBean;

public class EventDAO {
	// 1.
	private EventDAO() {}
	// 2. 5.
//    private static BoardDAO instance = new BoardDAO();
	private static EventDAO instance;
	// 3.
	public static EventDAO getInstance() {
		// BoardDAO 객체가 없을 경우에만 만들어줌
		if(instance == null) {
			instance = new EventDAO();
		}
		return instance;
	}
	
	// 여기까지 싱글톤 패턴
	// -----------------------------------------
	
	Connection con ; // Connection 객체 전달받아 저장할 변수 선언
	
	// Service 클래스로부터 Connection 객체를 전달받는 메서드 setConnection()정의
	public void setConnection(Connection con) {
		this.con = con;
		
	}

	public int registEvent(EventBean eventBean) {
		
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		
		System.out.println( eventBean.getEvent_titie());
		System.out.println(eventBean.getEvent_content());
		System.out.println(eventBean.getEvent_time());

		try {
			System.out.println("insertArticle- try ");
			
			String sql = "INSERT INTO event_board VALUES(null,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventBean.getEvent_titie());
			pstmt.setString(2, eventBean.getEvent_content());
			pstmt.setTimestamp(3, eventBean.getEvent_time());
			pstmt.setString(4, eventBean.getCondition());
			pstmt.setInt(5, eventBean.getDiscount());
			pstmt.setString(6, eventBean.getEvent_start());
			pstmt.setString(7, eventBean.getEvent_limit());
			pstmt.setString(8, eventBean.getEvent_img());
			
			
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("EventDAO- registEvent()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		
		
		return insertCount;
	}
	
	public int selectListCount() {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "SELECT COUNT(num) FROM event_board";
			pstmt= con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("EventDAO- selectListCount()실패!"+e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		}
		
		
		return listCount;
	}

	public ArrayList<EventBean> selectArticleList(int page, int limit) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (page -1)*limit;
		
		ArrayList<EventBean> articleList =  new ArrayList<EventBean>();
		
		
		try {
			// 게시물 갯수 조회할 SQL 구문 작성
			// => 정렬 : board_re_ref 기준 내림차순, board_re_seq 기준 오름차순
			// => limit : 시작 행 번호부터 지정된 게시물 갯수 만큼 제한
	String sql = "SELECT * FROM event_board LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, page);
			pstmt.setInt(2, limit);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventBean rowData = new EventBean();
				rowData.setEvent_titie(rs.getString("event_title"));
				rowData.setEvent_content(rs.getString("event_content"));
				rowData.setEvent_time(rs.getTimestamp("event_time"));
				rowData.setCondition(rs.getString("condition"));
				rowData.setDiscount(rs.getInt("discount_per"));
				rowData.setEvent_start(rs.getString("event_start"));
				rowData.setEvent_limit(rs.getString("event_limit"));
				rowData.setEvent_img(rs.getString("event_img"));
			
				articleList.add(rowData);
			}
		} catch (SQLException e) {
			System.out.println("EventDAO- selectArticleList()실패!"+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return articleList;
	}

	
	
	

}
