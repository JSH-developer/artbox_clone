package dao;

import static db.jdbcUtil.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import vo.BasketBean;
import vo.ProductBean;

public class BasketDAO {
	public BasketDAO() {}
	
	private static BasketDAO instance = new BasketDAO();
	
	public static BasketDAO getInstance() {
		// basketDAO 객체가 없을 경우에만 생성
		if(instance == null) {
			instance = new BasketDAO();
		}
		return instance;
	}
	
	Connection con; // Connection 객체 전달받아 저장할 변수 선언
	
	// Service 클래스로부터 Connection 객체를 전달받는 메서드 setConnection() 정의
	public void setConnection(Connection con) {
		this.con = con; // 이름이 똑같기 때문에 this. 적음
	}
	
	// 장바구니 INSERT
	public int insertBasket(BasketBean basketBean) {
		// Service 클래스로부터 BasketBean 객체를 전달받아 DB 에 INSERT 작업 수행
		// => 수행 결과 값으로 int형 insertCount 를 리턴받아 다시 Service 클래스로 리턴
		int insertCount = 0;
		
		// DB 작업에 필요한 변수 선언(Connection 객체는 이미 외부로부터 전달받음)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			int basket_num = 1; // 새 장바구니 번호를 저장할 변수(초기값으로 초기번호 1번 설정)
			
			String sql = "SELECT MAX(num) FROM basket";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 등록된 장바구니가 하나라도 존재할 경우 장바구니 번호 조회 성공
				// 조회된 번호 + 1 을 수행하여 새 장바구니 번호로 저장
				basket_num = rs.getInt(1) + 1;
			}
			// => 만약 조회가 실패할 경우 새 장바구니 번호는 1번이므로 기본값 basket_num 그대로 사용
			
			// 전달받은 데이터와 계산된 장바구니 번호를 사용하여 INSERT 작업 수행
			sql = "INSERT INTO basket VALUES(?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, basket_num);
			pstmt.setInt(2, basketBean.getBasket_quantity());
			pstmt.setString(3, basketBean.getBasket_member_id());
			pstmt.setInt(4, basketBean.getBasket_product_num());
			
			// INSERT 구문 실행 후 리턴되는 결과값을 insertCount 변수에 저장
			insertCount = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("BasketDAO - insertBasket() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return insertCount;
	}
	
	// 장바구니 목록 출력 (Basket.jsp)
	public List selectBasketList(String member_id) {
		// member_id 에 해당하는 장바구니 목록 전체 조회
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs2 = null;
		
		List list = new ArrayList();
		List basketList = new ArrayList();
		List itemsList = new ArrayList();
		try {
			String sql = "SELECT * FROM basket WHERE member_id=? ORDER BY regdate DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BasketBean basket = new BasketBean();
				basket.setBasket_num(rs.getInt("num"));
				basket.setBasket_quantity(rs.getInt("quantity"));
				basket.setBasket_regdate(rs.getTimestamp("regdate"));
				basket.setBasket_product_num(rs.getInt("product_num"));
				basket.setBasket_member_id(rs.getString("member_id"));
				basketList.add(basket);
				
				// num 에 해당하는 상품 조회해오기
				sql = "SELECT * FROM product WHERE num=?";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.setInt(1, basket.getBasket_product_num());
				rs2 = pstmt2.executeQuery();
				while(rs2.next()) {
					ProductBean productBean = new ProductBean();
					productBean.setProduct_code(rs2.getString("code"));
					productBean.setProduct_price(rs2.getInt("price"));
					productBean.setProduct_name(rs2.getString("name"));
					productBean.setProduct_image(rs2.getString("image"));
					productBean.setProduct_sale_price(rs2.getInt("sale_price"));
					itemsList.add(productBean);
				}
			}
			// list 첫번째 칸 basketList 저장
			list.add(basketList);
			// list 두번째 칸 itemsList 저장
			list.add(itemsList);
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("BasketDAO - selectBasketList() 실패! : " + e.getMessage());
		} finally {
			close(rs2);
			close(pstmt2);
			close(rs);
			close(pstmt);
		}
		return list;
	}

	// 장바구니에 담겨있는 상품일 경우, 수량 추가
	public int checkItems(BasketBean basketBean) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = 0;
		try{
			// 장바구니에 이미 담겨있는 상품인지 조회
			String sql = "SELECT * FROM basket WHERE member_id=? AND product_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, basketBean.getBasket_member_id());
			pstmt.setInt(2, basketBean.getBasket_product_num());
			
			rs=pstmt.executeQuery();
			// rs 데이터 있으면 check = 1
			if(rs.next()){
				check = 1;
				// 장바구니에 있는 상품일 경우, 상품 개수만 증가시킴
				sql="UPDATE basket SET quantity=quantity+? WHERE member_id=? AND product_num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, basketBean.getBasket_quantity());
				pstmt.setString(2, basketBean.getBasket_member_id());
				pstmt.setInt(3, basketBean.getBasket_product_num());
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("BasketDAO - checkItems() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return check;
	}
	
	// 상품 수량 변경
	public int updateQuantity(int quantity, int num) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int updateCount = 0;
		try{
			String sql = "SELECT * FROM basket WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			// rs 데이터 있으면 updateCount = 1
			if(rs.next()){
				updateCount = 1;
				sql="UPDATE basket SET quantity=? WHERE num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, quantity);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("BasketDAO - updateQuantity() 실패! : " + e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return updateCount;
	}
	
	// 상품 삭제
	public int deleteBasket(String member_id, int product_num){
		PreparedStatement pstmt = null;
		int deleteCount = 0;
		try {
			String sql = "DELETE FROM basket WHERE member_id=? AND product_num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setInt(2, product_num);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			System.out.println("BasketDAO - deleteBasket() 실패! : " + e.getMessage());
		} finally {
			close(pstmt);
		}
		return deleteCount;
	}
	
}
