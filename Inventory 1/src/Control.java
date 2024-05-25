import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Control {
public static Connection getConn(){
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Connection connection =null;
		
		try {
			connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root",""
);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return connection;
		
	}
}
