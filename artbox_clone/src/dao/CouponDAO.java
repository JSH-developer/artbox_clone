package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import static db.jdbcUtil.*;

import vo.CouponBean;

public class CouponDAO {
	// 1.
	private CouponDAO() {}
	// 2. 5.
//    private static BoardDAO instance = new BoardDAO();
	private static CouponDAO instance;
	// 3.
	public static CouponDAO getInstance() {
		// BoardDAO 객체가 없을 경우에만 만들어줌
		if(instance == null) {
			instance = new CouponDAO();
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

	public int insertArticle(CouponBean couponBean) {
		int insertCount = 0;
		
		PreparedStatement pstmt = null;
		
		System.out.println( couponBean.getCoupon_name());
		System.out.println(couponBean.getCoupon_price());
		System.out.println(couponBean.getCoupon_condition());
		System.out.println(couponBean.getCoupon_start());
		System.out.println(couponBean.getCoupon_limit());
		System.out.println( couponBean.getCoupon_reason());
		System.out.println(couponBean.getCoupon_member_id());
		System.out.println(couponBean.getCoupon_img());
		
		
		try {
			System.out.println("insertArticle- try ");
			
			String sql = "INSERT INTO coupon VALUES(null,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			System.out.println("con null??? "+con);
			pstmt.setString(1, couponBean.getCoupon_name());
			pstmt.setInt(2, couponBean.getCoupon_price());
			pstmt.setString(3, couponBean.getCoupon_condition());
			pstmt.setString(4,couponBean.getCoupon_start());
			pstmt.setString(5,couponBean.getCoupon_limit());
			pstmt.setInt(6, 0); // 사용여부
			pstmt.setString(7, couponBean.getCoupon_reason());
			pstmt.setString(8, couponBean.getCoupon_member_id());
			pstmt.setString(9, couponBean.getCoupon_img());
			
			System.out.println("쿠폰이름: "+couponBean.getCoupon_name());
			insertCount = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			System.out.println("CouponDAO- insertArticle()실패!"+e.getMessage());
		} finally {
			close(pstmt);
		}
		
		return insertCount;
	}

	// 쿠폰 리스트 불러오기
	public ArrayList<CouponBean> selectmyCouponlist(String id) {
		
		ArrayList<CouponBean> couponList =  new ArrayList<CouponBean>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM coupon WHERE member_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CouponBean couponBean = new CouponBean();
				couponBean.setCoupon_name(rs.getString("coup_name"));
				couponBean.setCoupon_price(rs.getInt("coup_price"));
				couponBean.setCoupon_condition(rs.getString("condition"));
				couponBean.setCoupon_start(rs.getString("coup_start"));
				couponBean.setCoupon_limit(rs.getString("coup_limit"));
				couponBean.setCoupon_use(rs.getInt("coup_use"));
				couponBean.setCoupon_reason(rs.getString("coup_reason"));
				couponBean.setCoupon_member_id(rs.getString("member_id"));
				
				
				couponList.add(couponBean);
			}
			
		}catch (SQLException e) {
			System.out.println("CouponDAO- selectCouponlist()실패!"+e.getMessage());
		} finally {
			close(pstmt);
			close(rs);
		}
		
		
		return couponList;
	}

	
	
	
	
	
}
