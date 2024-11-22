<%-- 
    Document   : order
    Created on : 12 thg 10, 2024, 15:24:09
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            html, body {
                height: 100%;
                margin: 0;
            }
            .container {
                min-height: calc(100vh - 100px); /* Chiều cao tối thiểu của nội dung */
            }
            /* Make all menu item images the same size */
            .menu-item img {
                width: 100%;
                height: 300px;
                /* Fixed height */
                object-fit: cover;
                /* Ensures the image fills the container while maintaining aspect ratio */
                border-radius: 8px;
                /* Optional: Rounded corners for the images */
            }

            /* Additional padding for items */
            .menu-item {
                margin-bottom: 20px;
            }

            /* Optional: Styling for the text and buttons */
            .menu-item h5 {
                margin-top: 10px;
                font-size: 1.25rem;
                font-weight: 600;
            }

            .menu-item .price {
                font-size: 1.1rem;
                color: #5D4037;
                margin-bottom: 10px;
            }

        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <!--header-->
        <%@include file="header.jsp" %>

        <!-- Order details section -->
        <div class="container mt-4">
            <h2>Your Order</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Item</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="order-list">
                    <!-- Order items will be dynamically added here -->
                </tbody>
            </table>

            <h3>Total for Served Items: <span id="total-served">0</span></h3>
            <button class="btn btn-success" onclick="payOrder()">Pay</button>
        </div>

        <!--footer-->
        <%@include file="footer.jsp" %>
        <script src="js/order.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
