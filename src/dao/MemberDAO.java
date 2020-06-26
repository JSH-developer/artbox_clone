package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import static db.jdbcUtil.*;

import vo.MemberBean;

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
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
	public int JoinInsert(MemberBean bb) {
		PreparedStatement pstmt = null;
		int insertCount = 0;
		try {
			String sql = "insert into member values(null,?,?,?,?,?,?,?,?,?,0,?,?,1,now())";
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
			pstmt.setString(11, "bronz");
			
			insertCount = pstmt.executeUpdate();
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MemberDAO - JoinInsert() 실패 : "+e.getMessage());
		} finally {
			close(pstmt);
		}
		return insertCount;
		
		
	}
	
	public boolean idcheck(String id) {
		boolean idcheck = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
//				System.out.println("rs 아이디 : "+rs.getString("id"));
//				System.out.println("DAO id : "+id);
					idcheck =  true;
			}
		} catch (SQLException e) {
			System.out.println("DAO - idcheck 실패!"+e.getMessage());
		} finally {
			close(rs);
			close(pstmt);
		}
		return idcheck;
	}

	public int idpwSuccess(String id, String pw) {
		int LoginSuccess = -1; // 아이디 존재안함
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select pw from member where id = ?";
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
	
	
	public MemberBean myName(String id) {
		MemberBean bb = new MemberBean();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from member where id = ?";
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
	public void pwModify(String id, String newpw) {
		PreparedStatement pstmt = null;
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

	public int memberUpdate(MemberBean mb) {
		PreparedStatement pstmt = null;
		int success = 0;
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
			success = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("memberUpdate오류 - "+e.getMessage());
		}finally {
			close(pstmt);
		}
		return success;
		
	}

	public void memberDelete(String id) {
		PreparedStatement pstmt = null;
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

}
