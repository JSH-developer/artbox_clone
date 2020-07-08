package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static db.jdbcUtil.*;

import vo.MemberBean;
import vo.ReceiverBean;

public class MemberDAO {

	private static MemberDAO dao;
	
	private Connection con;
	
	private MemberDAO() {}
	
	public static MemberDAO getInstance() {
		if(dao==null) {
			dao = new MemberDAO();
		}
		return dao;
	}
	PreparedStatement pstmt;
	ResultSet rs;
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	public int JoinInsert(MemberBean bb) { // 회원가입 INSERT
		int insertCount = 0;
		try {
			String sql = "INSERT INTO member VALUES(null,?,?,?,?,?,?,?,?,?,10000,?,?,1,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bb.getId());
			pstmt.setString(2, bb.getPw());
			pstmt.setString(3, bb.getName());
			pstmt.setString(4, bb.getPostcode());
			pstmt.setString(5, bb.getAddr_basic());
			pstmt.setString(6, bb.getAddr_detail());
			pstmt.setString(7, bb.getEmail());
			pstmt.setString(8, bb.getPhone());
			pstmt.setString(9, bb.getGender());
			pstmt.setString(10, bb.getBirth());
			pstmt.setString(11, "BRONZ");
			
			insertCount = pstmt.executeUpdate();
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MemberDAO - JoinInsert() 실패 : "+e.getMessage());
		} finally {
			close(pstmt);
		}
		return insertCount;
		
		
	}
	
	public boolean idcheck(String id) { //아이디 중복 체크
		boolean idcheck = false;
		
		try {
			String sql = "SELECT * FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
					idcheck =  true; //아이디 중복!
			}
		} catch (SQLException e) {
			System.out.println("DAO - idcheck 실패!"+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return idcheck;
	}

	public int idpwSuccess(String id, String pw) { // 패스워드 체크
		int LoginSuccess = -1; // 아이디 존재안함
		
		try {
			String sql = "SELECT pw FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(pw)) {
					LoginSuccess = 1; // 패스워드 일치
				}else {
					LoginSuccess = 0; // 패스워드 틀림
				}
			}
		} catch (SQLException e) {
			System.out.println("idpwSuccess오류 - "+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return LoginSuccess;
	}
	
	
	public MemberBean myName(String id) { //로그인 후 NAME 세션값 지정 및 프로필 들고오기
		MemberBean bb = new MemberBean();
		
		try {
			String sql = "SELECT * FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setPw(rs.getString("pw"));
				bb.setName(rs.getString("name"));
				bb.setPostcode(rs.getString("postcode"));
				bb.setAddr_basic(rs.getString("addr_basic"));
				bb.setAddr_detail(rs.getString("addr_detail"));
				bb.setEmail(rs.getString("email"));
				bb.setPhone(rs.getString("phone"));
				bb.setGender(rs.getString("gender"));
				bb.setPoint(rs.getInt("point"));
				bb.setBirth(rs.getString("birth"));
				bb.setGrade(rs.getString("grade"));
				bb.setStatus(rs.getInt("status"));
				bb.setRegdate(rs.getDate("regdate"));
				
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return bb;
		
		
	}
	public void pwModify(String id, String newpw) { // 비밀번호 변경
		try {
			String sql = "UPDATE member SET pw = ? WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, newpw);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("pwModify오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
	}

	public void memberUpdate(MemberBean mb) { //회원정보 변경
		try {
			String sql = "UPDATE member SET gender=?,birth=?,postcode=?,addr_basic=?,addr_detail=?,email=?,phone=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getGender());
			pstmt.setString(2, mb.getBirth());
			pstmt.setString(3, mb.getPostcode());
			pstmt.setString(4, mb.getAddr_basic());
			pstmt.setString(5, mb.getAddr_detail());
			pstmt.setString(6, mb.getEmail());
			pstmt.setString(7, mb.getPhone());
			pstmt.setString(8, mb.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("memberUpdate오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
		
	}

	public void memberDelete(String id) { // 회원탈퇴
		try {
			String sql = "DELETE FROM member WHERE id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("pwModify오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
	}

	public ReceiverBean ReceiverModify(int receiverNum) { // 배송지 리스트
		ReceiverBean rb = new ReceiverBean();
		try {
			String sql = "SELECT * FROM receiver WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, receiverNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rb.setReceiver_num(rs.getInt("num"));
				rb.setReceiver(rs.getString("receiver"));
				rb.setReceiver_name(rs.getString("receiver_name"));
				rb.setReceiver_phone(rs.getString("receiver_phone"));
				rb.setReceiver_postcode(rs.getString("receiver_postcode"));
				rb.setReceiver_addr(rs.getString("receiver_addr"));
				rb.setReceiver_addr_detail(rs.getString("receiver_addr_detail"));
			}
			
		} catch (Exception e) {
			System.out.println("pwModify오류 - "+e.getMessage());
		}finally {
			close(pstmt);
			close(rs);
		}
		
		
		return rb;
	}

	public void rModifyUpdate(ReceiverBean rb) { //배송지 수정
		try {
//			System.out.println(rb.getReceiver()+", "+rb.getReceiver_name()+", "+rb.getReceiver_phone()+", "+rb.getReceiver_postcode()+", "+rb.getReceiver_addr()+", "+rb.getReceiver_addr_detail()+", "+rb.getReceiver_num());
			String sql = "UPDATE receiver SET receiver=?,receiver_name=?,receiver_phone=?,receiver_postcode=?,receiver_addr=?,receiver_addr_detail=? WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,rb.getReceiver() );
			pstmt.setString(2,rb.getReceiver_name() );
			pstmt.setString(3,rb.getReceiver_phone() );
			pstmt.setString(4,rb.getReceiver_postcode() );
			pstmt.setString(5,rb.getReceiver_addr() );
			pstmt.setString(6,rb.getReceiver_addr_detail() );
			pstmt.setInt(7,rb.getReceiver_num() );
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("rModifyUpdate오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
		
	}

	public void ReceiverDelete(int receiverNum) { // 배송지 삭제
		System.out.println("DAO - ReceiverDelete");
		
		try {
			String sql = "DELETE FROM receiver WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,receiverNum );
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("ReceiverDelete오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
	}

	public void ReceiverBasic(int receiverNum, String id) { // 기본배송지 설정
		System.out.println("DAO - ReceiverBasic");
		int rs = -1;
		
		try {
			String sql = "UPDATE receiver SET basic_num = 0 WHERE member_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id );
			rs = pstmt.executeUpdate();
			System.out.println("rs - "+rs);
				sql = "UPDATE receiver SET basic_num = 1 WHERE num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,receiverNum );
				pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("ReceiverBasic오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
	}

	public String findId(MemberBean bb) { // 아이디 찾기
		System.out.println("DAO - findId");
		String id = null;
		try {
			String sql = "SELECT id FROM member WHERE name=? AND (phone=? OR email=?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bb.getName());
			pstmt.setString(2,bb.getPhone());
			pstmt.setString(3,bb.getEmail());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("id");
				System.out.println("id 값 - "+id);
			}
			
		} catch (Exception e) {
			System.out.println("findId오류 - "+e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return id;
	}

	public int orderCount(String id) {
		int orderCount = 0;
		try {
			String sql = "SELECT count(num) as 'orderCount' FROM orders where member_id = ? AND state <> -1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				orderCount = rs.getInt("orderCount");
			}
		} catch (Exception e) {
			System.out.println("orderCount오류 - "+e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		}
		return orderCount;
	}

	public int coupCount(String id) {
		int coupCount = 0;
		try {
			String sql = "SELECT count(num) as 'couponCount' FROM coupon where member_id = ? and coup_use =1";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				coupCount = rs.getInt("couponCount");
			}
		} catch (Exception e) {
			System.out.println("coupCount오류 - "+e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		}
		return coupCount;
	}

	public int reviewCount(String id) {
		int reviewCount = 0;
		try {
			String sql = "SELECT count(num) as 'reviewCount' FROM review where member_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reviewCount = rs.getInt("reviewCount");
			}
		} catch (Exception e) {
			System.out.println("coupCount오류 - "+e.getMessage());
		}finally {
			close(rs);
			close(pstmt);
		}
		return reviewCount;
	}

}
