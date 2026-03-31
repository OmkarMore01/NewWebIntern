

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.util.JdbcLoader;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		String uname=request.getParameter("uname");
		String pass=request.getParameter("pass");
		boolean isMatch=false;
		
		try {
			Connection con=JdbcLoader.getconnection();
			String sql="select *from userregister";
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery(sql);
			while(rs.next())
			{
				if(uname.equals(rs.getString("uname"))&&pass.equals(rs.getString("password")))
				{
					isMatch=true;
					HttpSession session=request.getSession(true);
					session.setAttribute("uname",rs.getString("uname"));
				}
			}
			
		}catch (Exception e) {
			System.out.println(e);
		}
		
		if(isMatch)
		{
			out.println("<script>"
					+ "alert('Login Successfull');"
					+ "window.location.href='home.jsp';"
					+ "</script>");
			
		}
		else {
			out.println("<script>"
					+ "alert('Login Failed');"
					+ "window.location.href='Login.html';"
					+ "</script>");
		}
		
		
		
		
	}

}
