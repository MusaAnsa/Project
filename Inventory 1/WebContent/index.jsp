<!DOCTYPE html>
<html>
<head>
    <title>Add Inventory Item</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Add Inventory Item</h2>
        <form method="post" action="Controller">
            <div class="mb-3">
                <label for="itemName" class="form-label">Item Name</label>
                <input type="text" class="form-control" id="itemName" name="itemName" required>
            </div>
            <div class="mb-3">
                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" class="form-control" id="quantity" name="quantity" required>
            </div>
            <div class="mb-3">
                <label for="availableQuantity" class="form-label">Available Quantity</label>
                <input type="number" class="form-control" id="availableQuantity" name="availableQuantity" required>
            </div>
            <div class="mb-3">
                <label for="daysOfSupply" class="form-label">Days of Supply</label>
                <input type="number" class="form-control" id="daysOfSupply" name="daysOfSupply" required>
            </div>
            <div class="mb-3">
              <label for="recentSalesTrend" class="form-label">Recent Sales Trend</label>
              <select class="form-select" id="recentSalesTrend" name="recentSalesTrend" required>
                  <option value="">Select Trend</option>
                  <option value="Increasing">Increasing</option>
                  <option value="Stable">Stable</option>
                  <option value="Decreasing">Decreasing</option>
              </select>
          </div>
          
            <div class="mb-3">
                <label for="minimumStockLevel" class="form-label">Minimum Stock Level</label>
                <input type="number" class="form-control" id="minimumStockLevel" name="minimumStockLevel" required>
            </div>
            <div class="d-grid">
                <input type="submit" class="btn btn-primary" value="Add Item">
            </div>
        </form>
    </div>
    <!-- Include Bootstrap JS (optional, for features like modal, tooltip) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>