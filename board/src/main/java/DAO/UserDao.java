package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import DTO.UserDto;

public class UserDao {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDao() {
	
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "dkthk123";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("성공!");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	public int login(String userID, String userPassword) {
		
		String sql = "select userPassword from user where userID = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			
			rs = pstmt.executeQuery();
			
			
			
			if(rs.next()) {
				System.out.println("1번재");
				if(rs.getString(1).equals(userPassword)) {
						return 1;
				}
					else {
						return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return -2;
	}
	
	public int join(UserDto userDto) {
		String sql = "insert into user values(?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
		    pstmt.setString(1, userDto.getUserID());
		    pstmt.setString(2, userDto.getUserPassword());
		    pstmt.setString(3, userDto.getUserName());
		    pstmt.setString(4, userDto.getUserGender());
		    pstmt.setString(5, userDto.getUserEmail());
		    return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
}
