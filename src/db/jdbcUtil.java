package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class jdbcUtil {
	// DB 관련 기본 기능 (연결, 자원반환, commit, rollback 등)을 담당하는 클래스
	// 1. DBCP 기능을 활용한 Connection 객체 가져오는 메서드 getConnection()
	
	public static Connection getConnection() {
		Connection con =null;
		
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/MySQL");
			
			con = ds.getConnection();
			
			// DB 작업에 대한 Auto Commit 기능 해제
			con.setAutoCommit(false); // 기본값은 true임
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return con;
	}
	
	// 메서드 오버로딩을 활용하여 Connection, PreparedStatement, ResultSet 객체 자원 반환 구현
	public static void close(Connection con) {
		if(con!=null) try {con.close();} catch (SQLException e) {e.printStackTrace();}
	}
	
	public static void close(PreparedStatement pstmt) {
		if(pstmt!=null) try {pstmt.close();} catch (SQLException e) {e.printStackTrace();}
	}
	
	public static void close(ResultSet rs) {
		if(rs!=null) try {rs.close();} catch (SQLException e) {e.printStackTrace();}
	}
	
	// Auto Commit 해제로 인해 Commit, Rollback 기능을 수행하는 각각의 메서드 정의
	public static void commit(Connection con) {
		if(con!=null) try {con.commit();} catch (SQLException e) {e.printStackTrace();}
	}
	
	public static void rollback(Connection con) {
		if(con!=null) try {con.rollback();} catch (SQLException e) {e.printStackTrace();}
	}
	
}
