package com.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class JdbcLoader {
		
	public static Connection getconnection()
	{
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url="jdbc:mysql://localhost:3306/laptopshop";
			String user="root";
			String pass="8284";
			Connection con=DriverManager.getConnection(url,user,pass);
			return con;
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

}
