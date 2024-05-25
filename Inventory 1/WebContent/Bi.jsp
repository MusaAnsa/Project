<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inventory Data</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * {
            font-family: "Poppins", sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            padding: 20px;
        }

        .table_container {
            overflow-x: auto;
            margin: 20px 0;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        .card_container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
        }

        .card {
            width: calc(33.33% - 10px);
            border-radius: 10px;
            border: 1px solid #000;
            font-size: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            padding: 10px;
        }

        .card-body {
            padding: 10px;
            font-weight: 400;
        }

        .graph_container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .graph {
            width: calc(50% - 5px);
        }

        @media only screen and (max-width: 768px) {
            .card {
                width: 100%;
            }

            .graph {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <h1>Inventory BI Data</h1>
    
    <%
        String url = "jdbc:mysql://localhost:3306/test";
        String user = "root";
        String password = "";

        int totalStocks = 0;
        int totalProducts = 0;
        String mostSoldProduct = "";

        try {
        	
        	Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();

            // Total Stocks
            ResultSet stocksResult = stmt.executeQuery("SELECT SUM(Quantity) AS TotalStocks FROM inventory");
            if (stocksResult.next()) {
                totalStocks = stocksResult.getInt("TotalStocks");
            }

            // Total Products
            ResultSet productsResult = stmt.executeQuery("SELECT COUNT(*) AS TotalProducts FROM inventory");
            if (productsResult.next()) {
                totalProducts = productsResult.getInt("TotalProducts");
            }

            // Most Sold Product
            ResultSet mostSoldResult = stmt.executeQuery("SELECT ItemName FROM inventory ORDER BY Quantity DESC LIMIT 1");
            if (mostSoldResult.next()) {
                mostSoldProduct = mostSoldResult.getString("ItemName");
            }

            // Closing ResultSets and Statement
            stocksResult.close();
            productsResult.close();
            mostSoldResult.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

    <h2>Quick Info</h2>
    <div class="card_container">
        <div class="card">
            <div class="card-title">Total Stocks</div>
            <div class="card-body"><%= totalStocks %></div>
        </div>
        <div class="card">
            <div class="card-title">Total Products</div>
            <div class="card-body"><%= totalProducts %></div>
        </div>
        <div class="card">
            <div class="card-title">Most Sold Product</div>
            <div class="card-body"><%= mostSoldProduct %></div>
        </div>
    </div>

    <h2>Info Table</h2>
    <div class="table_container">
        <table>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Quantity</th>
                <th>Available Quantity</th>
                <th>Days of Supply</th>
                <th>Recent Sales Trend</th>
                <th>Minimum Stock Level</th>
            </tr>
            <%
                try {
                    Connection conn = DriverManager.getConnection(url, user, password);
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM inventory");

                    while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getInt("ItemId") %></td>
                            <td><%= rs.getString("ItemName") %></td>
                            <td><%= rs.getInt("Quantity") %></td>
                            <td><%= rs.getInt("AvailableQuantity") %></td>
                            <td><%= rs.getInt("DaysOfSupply") %></td>
                            <td><%= rs.getString("RecentSalesTrend") %></td>
                            <td><%= rs.getInt("MinimumStockLevel") %></td>
                        </tr>
                        <%
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>

    <h2>Graph</h2>
    <div class="graph_container">
        <div class="graph">
            <canvas id="inventoryChart" width="400" height="200"></canvas>
        </div>
        <div class="graph">
            <canvas id="trendChart" width="400" height="200"></canvas>
        </div>
    </div>

    <%
        // Convert fetched data to JavaScript arrays
        StringBuilder itemNames = new StringBuilder();
        StringBuilder quantities = new StringBuilder();
        StringBuilder availableQuantities = new StringBuilder();
        StringBuilder minimumStockLevels = new StringBuilder();
        StringBuilder quantityDifferences = new StringBuilder();

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT ItemName, Quantity, AvailableQuantity, MinimumStockLevel FROM inventory");

            while (rs.next()) {
                if (itemNames.length() > 0) {
                    itemNames.append(", ");
                    quantities.append(", ");
                    availableQuantities.append(", ");
                    minimumStockLevels.append(", ");
                    quantityDifferences.append(", ");
                }
                String itemName = rs.getString("ItemName");
                int quantity = rs.getInt("Quantity");
                int availableQuantity = rs.getInt("AvailableQuantity");
                int difference = availableQuantity - quantity;

                itemNames.append("'").append(itemName).append("'");
                quantities.append(quantity);
                availableQuantities.append(availableQuantity);
                minimumStockLevels.append(rs.getInt("MinimumStockLevel"));
                quantityDifferences.append(difference);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

    <script>
        // Convert Java arrays to JavaScript arrays
        const itemNames = [<%= itemNames.toString() %>];
        const quantities = [<%= quantities.toString() %>];
        const availableQuantities = [<%= availableQuantities.toString() %>];
        const minimumStockLevels = [<%= minimumStockLevels.toString() %>];
        const quantityDifferences = [<%= quantityDifferences.toString() %>];

        // Render the bar chart
        const ctx = document.getElementById('inventoryChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: itemNames,
                datasets: [{
                    label: 'Quantity',
                    data: quantities,
                    backgroundColor: '#0072B2',
                    borderColor: '#0072B2',
                    borderWidth: 1
                },
                {
                    label: 'Available Quantity',
                    data: availableQuantities,
                    backgroundColor: '#D55E00',
                    borderColor: '#D55E00',
                    borderWidth: 1
                },
                {
                    label: 'Minimum Stock Level',
                    data: minimumStockLevels,
                    backgroundColor: '#CC79A7',
                    borderColor: '#CC79A7',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.label + ': ' + context.raw;
                            }
                        }
                    }
                }
            }
        });

        // Render the trend chart
        const trend = document.getElementById('trendChart').getContext('2d');
        new Chart(trend, {
            type: 'line',
            data: {
                labels: itemNames,
                datasets: [{
                    label: 'Available Quantity - Quantity',
                    data: quantityDifferences,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                },
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.label + ': ' + context.raw;
                            }
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>