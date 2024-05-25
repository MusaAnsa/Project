
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//int itemId = Integer.parseInt(request.getParameter("itemId"));
				String itemName = request.getParameter("itemName");
				int quantity = Integer.parseInt(request.getParameter("quantity"));
				int availableQuantity = Integer.parseInt(request.getParameter("availableQuantity"));
				int daysOfSupply = Integer.parseInt(request.getParameter("daysOfSupply"));
				String recentSalesTrend = request.getParameter("recentSalesTrend");
				int minimumStockLevel = Integer.parseInt(request.getParameter("minimumStockLevel"));
				
				Pojo add = new Pojo();
				
				add.setAvailableQuantity(availableQuantity);
				add.setDaysOfSupply(daysOfSupply);
				//add.setItemID(itemId);
				add.setItemName(itemName);
				add.setQuantity(quantity);
				add.setMinimumStockLevel(minimumStockLevel);
				add.setRecentSalesTrend(recentSalesTrend);

				try {
				

					PreparedStatement ps = Control.getConn().prepareStatement(
							"INSERT INTO inventory (  ItemName, Quantity, AvailableQuantity, DaysOfSupply, RecentSalesTrend, MinimumStockLevel) VALUES (?, ?, ?, ?, ?, ?);");

					
					ps.setString(1, add.getItemName());
					ps.setInt(2, add.getQuantity());
					ps.setInt(3, add.getAvailableQuantity());
					ps.setInt(4, add.getDaysOfSupply());
					ps.setString(5, add.getRecentSalesTrend());
					ps.setInt(6, add.getMinimumStockLevel());

					 int rowsAffected = ps.executeUpdate();
				        if (rowsAffected > 0) {
				            // Forward to success page
				            request.getRequestDispatcher("Success.jsp").forward(request, response);
				        } else {
				            // Forward to error page
				            request.getRequestDispatcher("error.jsp").forward(request, response);
				        }
					System.out.println("inserted");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

		}	
}
