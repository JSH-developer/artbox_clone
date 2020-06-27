package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.eclipse.jdt.internal.compiler.ast.PrefixExpression;

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

	// 이벤트 등록 / 상품 할인 수정
	public int registEvent(EventBean eventBean) {
		
		int insertCount = 0;
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		

		try {
			
			String sql = "INSERT INTO event_board VALUES(null,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventBean.getEvent_titie());
			pstmt.setString(2, eventBean.getEvent_content());
			pstmt.setTimestamp(3, eventBean.getEvent_time());
			pstmt.setString(4, eventBean.getEvent_condition());
			pstmt.setInt(5, eventBean.getEvent_discount());
			pstmt.setString(6, eventBean.getEvent_start());
			pstmt.setString(7, eventBean.getEvent_limit());
			pstmt.setString(8, eventBean.getEvent_img());
			pstmt.setString(9, eventBean.getEvent_category());
			
			
			insertCount = pstmt.executeUpdate();
			int ediscount = eventBean.getEvent_discount();
			
			if(eventBean.getEvent_category().equals("coup_event")) {
					
				sql = "UPDATE product SET sale_price="+ediscount+" WHERE category_code=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, eventBean.getEvent_condition());
				
			}
			
			if(eventBean.getEvent_category().equals("sale_event")) {
			String discount="(price * "+ediscount+")/100";
				
			sql = "UPDATE product SET sale_price="+discount+" WHERE category_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventBean.getEvent_condition());
			
			}
			
			
			updateCount = pstmt.executeUpdate();
			if(updateCount>0) {
				System.out.println("상품 할인 적용 성공");
			}
			
		} catch (SQLException e) {
			System.out.println("EventDAO- registEvent()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		
		
		return insertCount;
	}
	
	// 이벤트 갯수
	public int selectListCount(String event_category) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "SELECT COUNT(num) FROM event_board WHERE event_category =?";
			pstmt= con.prepareStatement(sql);
			pstmt.setString(1, event_category);
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
	public ArrayList<EventBean> selectArticleList(int page, int limit,String event_category) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int updateCount = 0;
		
		int startRow = (page -1)*limit;
		
		ArrayList<EventBean> articleList =  new ArrayList<EventBean>();
		
		
		try {
			// 게시물 갯수 조회할 SQL 구문 작성
			// => 정렬 : board_re_ref 기준 내림차순, board_re_seq 기준 오름차순
			// => limit : 시작 행 번호부터 지정된 게시물 갯수 만큼 제한
			String sql = "SELECT * FROM event_board WHERE event_category=? ORDER BY num desc LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, event_category);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, limit);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventBean rowData = new EventBean();
				rowData.setEvent_num(rs.getInt("num"));
				rowData.setEvent_titie(rs.getString("event_title"));
				rowData.setEvent_content(rs.getString("event_content"));
				rowData.setEvent_time(rs.getTimestamp("event_time"));
				rowData.setEvent_condition(rs.getString("event_condition"));
				rowData.setEvent_discount(rs.getInt("event_discount"));
				rowData.setEvent_start(rs.getString("event_start"));
				rowData.setEvent_limit(rs.getString("event_limit"));
				rowData.setEvent_img(rs.getString("event_img"));
				rowData.setEvent_category(rs.getString("event_category"));
			
				articleList.add(rowData);
				
				Date nowDate = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				String limitdate = rs.getString("event_limit").replaceAll("-","");
				int limitdate1 = Integer.parseInt(limitdate);
				int nowwDate = Integer.parseInt(sf.format(nowDate));
				
//				if(nowwDate>limitdate1 ) {
//					sql = "UPDATE product SET sale_price=0 WHERE category_code=?";
//					pstmt = con.prepareStatement(sql);
//					pstmt.setString(1, rs.getString("event_condition"));
//					
//					updateCount = pstmt.executeUpdate();
//					
//					if(updateCount>0) {
//						System.out.println("상품 할인 내리기 성공");
//					}
//				}
				
			}
		} catch (SQLException e) {
			System.out.println("EventDAO- selectArticleList()실패!"+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return articleList;
	}
	
	// 클릭한 이벤트
		public EventBean selectEventArticle(int eBoard_Num) {
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			EventBean eventArticle =  null;
			
			try {
				String sql = "SELECT * FROM event_board WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, eBoard_Num);
				rs= pstmt.executeQuery();
				
				if(rs.next()) {
					eventArticle = new EventBean();
					eventArticle.setEvent_num(eBoard_Num);
					eventArticle.setEvent_titie(rs.getString("event_title"));
					eventArticle.setEvent_content(rs.getString("event_content"));
					eventArticle.setEvent_time(rs.getTimestamp("event_time"));
					eventArticle.setEvent_condition(rs.getString("event_condition"));
					eventArticle.setEvent_discount(rs.getInt("event_discount"));
					eventArticle.setEvent_start(rs.getString("event_start"));
					eventArticle.setEvent_limit(rs.getString("event_limit"));
					eventArticle.setEvent_img(rs.getString("event_img"));
					eventArticle.setEvent_category(rs.getString("event_category"));
					
				}
				
			} catch (SQLException e) {
				System.out.println("EventDAO- selectEventArticle()실패!"+e.getMessage());
			} finally {
				close(rs);
				close(pstmt);
			}
			
			
			
			
			return eventArticle;
		}

	// 클릭한 이벤트 카테고리에 저장된 상품 갯수
	public int selectEventItemListCount(String condition) {
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT COUNT(num) FROM product WHERE category_code like ?";
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

	// 클릭한 이벤트의 상품 리스트
	public ArrayList<ProductBean> selectEventItemList(int page, int limit, String condition) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int startRow = (page -1)*limit;
		
		ArrayList<ProductBean> listProduct = new ArrayList<ProductBean>();
		
		
		try {
			String sql = "SELECT * FROM product WHERE category_code like ? LIMIT ?,?";
			ProductBean productBean = null;
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, condition);
			pstmt.setInt(2, startRow);
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

	// 이벤트 수정
	public int modifyEvent(EventBean eventBean) {
		int modifyCount = 0;
		
		PreparedStatement pstmt = null;
		
		System.out.println( eventBean.getEvent_titie());
		System.out.println( eventBean.getEvent_content());
		System.out.println(eventBean.getEvent_condition());
		System.out.println(eventBean.getEvent_discount());
		System.out.println (eventBean.getEvent_start());
		System.out.println(eventBean.getEvent_limit());
		System.out.println( eventBean.getEvent_img());
		System.out.println(eventBean.getEvent_num());

		try {
			System.out.println("modifyEvent- try ");
			
			String sql = "UPDATE event_board SET event_title=?,event_content=?,event_condition=?,event_discount=?,event_start=?,event_limit=?,event_img=?,event_category=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventBean.getEvent_titie());
			pstmt.setString(2, eventBean.getEvent_content());
			pstmt.setString(3, eventBean.getEvent_condition());
			pstmt.setInt(4, eventBean.getEvent_discount());
			pstmt.setString(5, eventBean.getEvent_start());
			pstmt.setString(6, eventBean.getEvent_limit());
			pstmt.setString(7, eventBean.getEvent_img());
			pstmt.setString(8, eventBean.getEvent_category());
			pstmt.setInt(9, eventBean.getEvent_num());
			
			
			modifyCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("EventDAO- modifyEvent()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return modifyCount;
	}

	// 이벤트 삭제
	public int deleteEvent(String board_num) {
		int deleteCount = 0;
		int updateCount =0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			String sql = "DELETE FROM event_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_num);
			deleteCount = pstmt.executeUpdate();
			
			
			sql = "UPDATE product SET sale_price=0 WHERE category_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rs.getString("event_condition"));
			
			updateCount = pstmt.executeUpdate();
			
			if(updateCount>0) {
				System.out.println("상품 할인 내리기 성공");
			}
			
			
		} catch (SQLException e) {
			System.out.println("EventDAO- deleteEvent()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		
		
		
		return deleteCount;
	}




	

	
	
	

}
