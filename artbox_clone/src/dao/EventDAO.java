package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.EventBean;
import vo.ProductBean;

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

	// 이벤트 등록
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
	
	// 이벤트 갯수
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

	// 이벤트 리스트
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

	// 클릭한 이벤트 카테고리에 저장된 상품 갯수
	public int selectEventItemListCount(String condition) {
		System.out.println("selectEventItemListCount condition : "+condition);
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(num) FROM product WHERE category_code like '?%'";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, condition);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println(rs.getInt(1));
				listCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("EventDAO- selectEventItemListCount()실패!"+e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		}
		
		
		return listCount;
	}

	public ArrayList<ProductBean> selectEventItemList(int page, int limit, String condition) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (page -1)*limit;
		
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		
		
		try {
			String sql = "SELECT * FROM product WHERE category_code like '?%' LIMIT ?,?";
			ProductBean productBean = null;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, condition);
			pstmt.setInt(2, page);
			pstmt.setInt(3, limit);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_code(rs.getString("code"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_image2(rs.getString("image2"));
				productBean.setProduct_description(rs.getString("description"));
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_brand(rs.getString("brand"));
				productBean.setProduct_stock_count(rs.getInt("stock_count"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
				productBean.setProduct_keywords(rs.getString("keywords"));
				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
				productBean.setProduct_category_code(rs.getString("category_code"));
				productBean.setProduct_option_code(rs.getString("option_code"));
				listProduct.add(productBean);
			}
		} catch (SQLException e) {
			System.out.println("EventDAO- selectEventItemList()실패!"+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return listProduct;
	}

	
	
	

}
