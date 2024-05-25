

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Del
 */
@WebServlet("/Del")
public class Del extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Del() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String itemName = request.getParameter("itemName");
		//int quantity = Integer.parseInt(request.getParameter("quantity"));
		//int availableQuantity = Integer.parseInt(request.getParameter("availableQuantity"));
		//int daysOfSupply = Integer.parseInt(request.getParameter("daysOfSupply"));
		//String recentSalesTrend = request.getParameter("recentSalesTrend");
		//int minimumStockLevel = Integer.parseInt(request.getParameter("minimumStockLevel"));
		
		Pojo del = new Pojo();
		
		//	add.setAvailableQuantity(availableQuantity);
		//add.setDaysOfSupply(daysOfSupply);
		//add.setItemID(itemId);
		del.setItemName(itemName);
		//	add.setQuantity(quantity);
		//add.setMinimumStockLevel(minimumStockLevel);
		//add.setRecentSalesTrend(recentSalesTrend);

		try {
		

			PreparedStatement ps = Control.getConn().prepareStatement(
					"delete from inventory where itemname =?  ");

			
			
			//	ps.setInt(1, add.getQuantity());
			//	ps.setInt(2, add.getAvailableQuantity());
			//	ps.setInt(3, add.getDaysOfSupply());
			//	ps.setString(4, add.getRecentSalesTrend());
			//	ps.setInt(5, add.getMinimumStockLevel());
			ps.setString(1, del.getItemName());
			int rowsAffected = ps.executeUpdate();
			if (rowsAffected > 0) {
	            // Forward to success page
	            request.getRequestDispatcher("Success.jsp").forward(request, response);
	        } else {
	            // Forward to error page
	            request.getRequestDispatcher("error.jsp").forward(request, response);
	        }
			System.out.println("deleted");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		doGet(request, response);
	}

}
