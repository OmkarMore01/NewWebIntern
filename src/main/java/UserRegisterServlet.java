

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.util.JdbcLoader;

/**
 * Servlet implementation class UserRegisterServlet
 */
@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");
		PrintWriter out=resp.getWriter();
		
		String name=req.getParameter("name");
		String username=req.getParameter("uname");
		String email=req.getParameter("email");
		String contact=req.getParameter("contact");
		String pass=req.getParameter("pass");
		try {
		Connection con=JdbcLoader.getconnection();
		String sql="insert into userregister(name,email,contact,uname,password) values(?,?,?,?,?)";
		PreparedStatement ps=con.prepareStatement(sql);
		ps.setString(1,name);
		ps.setString(2,email);
		ps.setString(3,contact);
		ps.setString(4,username);
		ps.setString(5,pass);
		int res=ps.executeUpdate();
		if(res!=0) {
		out.println("<script>"
				+ "alert('User Registration successfull');"
				+"window.location.href='Login.html';"
				+ "</script>");
		}
		else {
			out.println("<script>"
					+ "alert('User Registration Failed !!');"
					+"window.location.href='register.html';"
					+ "</script>");
		}
		
		
		
		}catch (Exception e) {
			out.println("<script>"
					+ "alert('User Registration Failed !!');"
					+"window.location.href='register.html';"
					+ "</script>");
			System.out.println(e);
		}
		
		}

}
