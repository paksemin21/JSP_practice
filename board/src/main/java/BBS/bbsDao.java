package BBS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DTO.bbsDto;

public class bbsDao {

	private Connection conn;
	private ResultSet rs;
	
	public bbsDao() {
	
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "dkthk123";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("¼º°ø!");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	public String getDate() {
		String sql = "select now()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
		
	}
	
	public int getNext() {
		String sql = "select bbsID from bbs order by bbsID desc";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String sql = "insert into bbs values(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); 
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<bbsDto> getList(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<bbsDto> list = new ArrayList<bbsDto>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bbsDto bbsdto = new bbsDto();
				bbsdto.setBbsID(rs.getInt(1));
				bbsdto.setBbsTitle(rs.getString(2));
				bbsdto.setUserID(rs.getString(3));
				bbsdto.setBbsDate(rs.getString(4));
				bbsdto.setBbsContent(rs.getString(5));
				bbsdto.setBbsAvailable(rs.getInt(6));
				list.add(bbsdto);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	public boolean nextPage(int pageNumber) {
		String sql = "select * from bbs where bbsID < ? and bbsAvailable = 1";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public bbsDto getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bbsDto bbsdto = new bbsDto();
				
				bbsdto.setBbsID(rs.getInt(1));
				bbsdto.setBbsTitle(rs.getString(2));
				bbsdto.setUserID(rs.getString(3));
				bbsdto.setBbsDate(rs.getString(4));
				bbsdto.setBbsContent(rs.getString(5));
				bbsdto.setBbsAvailable(rs.getInt(6));
				return bbsdto;
			} 
		}
			catch (Exception e) {
				e.printStackTrace();
			}
		return null;	
	}
}
