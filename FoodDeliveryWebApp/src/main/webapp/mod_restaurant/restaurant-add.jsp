<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Restaurant - FoodHub</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <jsp:include page="../jsp/navbar.jsp" />

    <div class="container" style="max-width: 600px;">
        <div class="card" style="padding: 40px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <h1>Add New Restaurant</h1>
                <a href="admin-dashboard.jsp" class="btn btn-secondary">Cancel</a>
            </div>

            <form action="../restaurant" method="POST">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label>Restaurant Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Location (City/Area)</label>
                    <input type="text" name="location" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Cuisine Type (e.g. Italian, Indian)</label>
                    <input type="text" name="cuisine" class="form-control" required>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Register Restaurant</button>
            </form>
        </div>
    </div>
</body>
</html>
