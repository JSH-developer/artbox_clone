package dao;

import static db.jdbcUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import vo.EventBean;
import vo.PointBean;
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
			
			String sql = "INSERT INTO event_board VALUES(null,?,?,?,?,?,?,?,?,?,1)";
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
			
			// 이벤트 등록 시 sale_price 등록해줌
			if(eventBean.getEvent_category().equals("sale_event") || eventBean.getEvent_category().equals("coup_event")) {
			String discount="(price * "+ediscount+")/100";
				
			sql = "UPDATE product SET sale_price="+discount+" WHERE category_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventBean.getEvent_condition());
			
			}
			
			updateCount = pstmt.executeUpdate();
			
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
			
			int ediscount = eventBean.getEvent_discount();
			
			// 할인 적용
			if(eventBean.getEvent_category().equals("sale_event") || eventBean.getEvent_category().equals("coup_event")) {
			String discount="(price * "+ediscount+")/100";
				
			
			sql = "UPDATE product SET sale_price="+discount+" WHERE category_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, eventBean.getEvent_condition());
			
			}
			
			int updateCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("EventDAO- modifyEvent()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return modifyCount;
	}

	// 이벤트 삭제
	public int deleteEvent(String board_num,String condition) {
		int deleteCount = 0;
		int updateCount =0;
		
		PreparedStatement pstmt = null;
		
		
		try {
			String sql = "DELETE FROM event_board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, board_num);
			deleteCount = pstmt.executeUpdate();
			
			// 이벤트 삭제시 sale_price = 0 으로 만듬
			sql = "UPDATE product SET sale_price=0 WHERE category_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,condition);
			
			updateCount = pstmt.executeUpdate();
	
			
			
		} catch (SQLException e) {
			System.out.println("EventDAO- deleteEvent()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		
		
		
		return deleteCount;
	}

	// admin용 전체 이벤트 리스트 count
	public int selectAllListCount() {
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

	// admin용 전체 이벤트 리스트 / main에 리스트 불러올때
	public ArrayList<EventBean> selectAllArticleList(int page, int limit) {
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		int updateCount = 0;
		
		int startRow = (page -1)*limit;
		
		ArrayList<EventBean> articleList =  new ArrayList<EventBean>();
		
		
		try {
			String sql = "SELECT * FROM event_board ORDER BY num desc LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, limit);
			
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
				rowData.setEvent_state(rs.getInt("event_state"));
			
				articleList.add(rowData);
	
			}
			
		} catch (SQLException e) {
			System.out.println("EventDAO- selectArticleList()실패!"+e.getMessage());
		} finally {
			close(pstmt2);
			close(rs);
			close(pstmt);
			
		}
		
		return articleList;
	}

	
	// 마이페이지 point
	public ArrayList<PointBean> selectMyPoint(String id) {
		ArrayList<PointBean> articleList= new ArrayList<PointBean>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select p.title, p.content, p.type, p.reg_date, p.point, p.member_id, m.point FROM point AS p JOIN member AS m ON p.member_id = m.id WHERE member_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			System.out.println("dao"+id);
			
			while(rs.next()) {
				PointBean rowData = new PointBean();
				rowData.setTitle(rs.getString("p.title"));
				rowData.setContent(rs.getString("p.content"));
				rowData.setType(rs.getString("p.type"));
				rowData.setPoint(rs.getInt("p.point"));
				rowData.setMember_id(rs.getString("p.member_id"));
				rowData.setReg_date(rs.getTimestamp("p.reg_date"));
				rowData.setMypoint(rs.getInt("m.point"));
				
			
				articleList.add(rowData);
				
			}
			
		} catch (SQLException e) {
			System.out.println("EventDAO- selectMyPoint()실패!"+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return articleList;
	}

	// new arrival 상품 불러오기
	public ArrayList<ProductBean> selectNewList() {
		ArrayList<ProductBean> newList= new ArrayList<ProductBean>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql="SELECT num,name,image,price,sale_price,regdate FROM product order by regdate desc limit 1,10";
			pstmt =con.prepareStatement(sql);
			
			rs= pstmt.executeQuery();
			
			while(rs.next()) {
				ProductBean productBean = new ProductBean();
				productBean = new ProductBean();
				productBean.setProduct_num(rs.getInt("num"));
				productBean.setProduct_name(rs.getString("name"));
				productBean.setProduct_image(rs.getString("image"));
				productBean.setProduct_price(rs.getInt("price"));
				productBean.setProduct_sale_price(rs.getInt("sale_price"));
//				productBean.setProduct_regdate(rs.getTimestamp("regdate"));
				newList.add(productBean);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return newList;
	}

	// 이벤트 내리기
	public int dropEvent(ArrayList<EventBean> eventList) {
		
		PreparedStatement pstmt = null;
		int updateCount = 0;
		try {
			
			for(int i=0;i<eventList.size();i++) {
				
				
			// 이벤트 종료 안되었을 때
			if(eventList.get(i).getEvent_state() ==1) {
				
				Date nowDate = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
				String limitdate = eventList.get(i).getEvent_limit().replaceAll("-","");
				int limitdate1 = Integer.parseInt(limitdate);
				int nowwDate = Integer.parseInt(sf.format(nowDate));
				


				if(nowwDate>limitdate1 ) {
					System.out.println("limitdate1"+limitdate1);
					System.out.println("nowwDate"+nowwDate);
					System.out.println(eventList.get(i).getEvent_condition());
					
					String sql2 = "UPDATE product SET sale_price = 0 WHERE category_code= ?";
					pstmt = con.prepareStatement(sql2);
					pstmt.setString(1, eventList.get(i).getEvent_condition());
					updateCount = pstmt.executeUpdate();
					
					sql2 = "UPDATE event_board SET event_state = 0 WHERE event_condition = ?";
					pstmt = con.prepareStatement(sql2);
					pstmt.setString(1, eventList.get(i).getEvent_condition());
					updateCount = pstmt.executeUpdate();


				}

			}
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return updateCount;
		
	}




	

	
	
	

}
