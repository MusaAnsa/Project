

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Update
 */
@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Update() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//int itemId = Integer.parseInt(request.getParameter("itemId"));
		String itemName = request.getParameter("itemName");
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int availableQuantity = Integer.parseInt(request.getParameter("availableQuantity"));
		int daysOfSupply = Integer.parseInt(request.getParameter("daysOfSupply"));
		String recentSalesTrend = request.getParameter("recentSalesTrend");
		int minimumStockLevel = Integer.parseInt(request.getParameter("minimumStockLevel"));
		
		Pojo upd = new Pojo();
		
		upd.setAvailableQuantity(availableQuantity);
		upd.setDaysOfSupply(daysOfSupply);
		//add.setItemID(itemId);
		upd.setItemName(itemName);
		upd.setQuantity(quantity);
		upd.setMinimumStockLevel(minimumStockLevel);
		upd.setRecentSalesTrend(recentSalesTrend);

		try {
		

			PreparedStatement ps = Control.getConn().prepareStatement(
					"update inventory set Quantity=?,AvailableQuantity=?,DaysOfSupply=?,RecentSalesTrend=?,MinimumStockLevel=? where ItemName=?   ");

			
			
			ps.setInt(1, upd.getQuantity());
			ps.setInt(2, upd.getAvailableQuantity());
			ps.setInt(3, upd.getDaysOfSupply());
			ps.setString(4, upd.getRecentSalesTrend());
			ps.setInt(5, upd.getMinimumStockLevel());
			ps.setString(6, upd.getItemName());

			 int rowsAffected = ps.executeUpdate();
		        if (rowsAffected > 0) {
		            // Forward to success page
		            request.getRequestDispatcher("Success.jsp").forward(request, response);
		        } else {
		            // Forward to error page
		            request.getRequestDispatcher("error.jsp").forward(request, response);
		        }
			System.out.println("update");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

}
}
