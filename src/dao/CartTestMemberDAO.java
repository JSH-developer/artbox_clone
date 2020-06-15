package dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CartTestMemberDAO {

	private Connection getConnection() throws Exception {

		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MySQL");
		con = ds.getConnection();

		return con;

	} // getconnection


	// 아이디 비밀번호 체크
	public int idcheck(String id, String pw) {
		int check = -1;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();

			String sql = "SELECT pw FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			// 비밀번호 맞음 check=1
			// 틀리면 check=0;
			// 없으면 아이디없음 check=-1
			if (rs.next()) {
				// 아이디있음
				if (pw.equals(rs.getString("pw"))) {
					// 로그인 성공
					check = 1;
				} else {
					// 비밀번호 틀림
					check = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 객체생성 닫기(기억장소를 회수하는 작업)
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException ex) {
				}
			}

		}
		return check;
	}
	
}