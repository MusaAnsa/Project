<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory BI Dashboard</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        .up {
            color: green;
        }
        .down {
            color: red;
        }
        .stable {
            color: gray;
        }
    </style>
</head>
<body>
    <h2>Inventory BI Dashboard</h2>
    <%
        // Database connection parameters
        String url = "jdbc:mysql://localhost:3306/test"; // Change yourdatabase to your actual database name
        String user = "root"; // Change to your database username
        String password = ""; // Change to your database password
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.jdbc.Driver");
            // Establish connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test","root",""
);
            stmt = conn.createStatement();
            // Execute query
            String sql = "SELECT * FROM inventory";
            rs = stmt.executeQuery(sql);
    %>
    <table>
        <tr>
            <th>ItemId</th>
            <th>ItemName</th>
            <th>Quantity</th>
            <th>AvailableQuantity</th>
            <th>DaysOfSupply</th>
            <th>RecentSalesTrend</th>
            <th>MinimumStockLevel</th>
            <th>Stock Status</th>
        </tr>
        <%
            // Iterate through the result set and print the data
            while (rs.next()) {
                int itemId = rs.getInt("ItemId");
                String itemName = rs.getString("ItemName");
                int quantity = rs.getInt("Quantity");
                int availableQuantity = rs.getInt("AvailableQuantity");
                int daysOfSupply = rs.getInt("DaysOfSupply");
                String recentSalesTrend = rs.getString("RecentSalesTrend");
                int minimumStockLevel = rs.getInt("MinimumStockLevel");
                
                // Calculate stock status
                String stockStatus = (availableQuantity < minimumStockLevel) ? "Low Stock" : "Sufficient Stock";

        %>
        <tr>
            <td><%= itemId %></td>
            <td><%= itemName %></td>
            <td><%= quantity %></td>
            <td><%= availableQuantity %></td>
            <td><%= daysOfSupply %></td>
            <td class="<%= recentSalesTrend.equals("Up") ? "up" : recentSalesTrend.equals("Down") ? "down" : "stable" %>">
                <%= recentSalesTrend %>
            </td>
            <td><%= minimumStockLevel %></td>
            <td><%= stockStatus %></td>
        </tr>
        <%
            }
        %>
    </table>
    <%
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error fetching inventory data: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>