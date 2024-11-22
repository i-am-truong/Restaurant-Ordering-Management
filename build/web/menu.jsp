<%-- 
    Document   : menu
    Created on : 12 thg 10, 2024, 13:15:02
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            /* Make all menu item images the same size */
            #menu-items {
                margin-bottom: 20px;  /* Tạo khoảng cách giữa menu và footer */
            }
            .menu-item img {
                width: 100%;
                height: 400px;
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
    </head>
    <body>
        <!--header-->
        <%@include file="header.jsp" %>

        <!-- Menu items section -->
        <div class="container mt-4">
            <div class="row" id="menu-items">
                <c:forEach items="${requestScope.data}" var="i">
                    <c:set var="id" value="${i.dishId}"></c:set>
                    <c:set var="name" value="${i.dishName}"></c:set>
                    <c:set var="price" value="${i.price}"></c:set>
                    <c:set var="status" value="${i.status}"></c:set>
                    <c:set var="imageLink" value="${i.image}"></c:set>
                    <c:if test="${status.equals('yes')}">
                        <!-- Menu Item --> 
                        <div class="col-md-4 menu-item">
                            <img src="${imageLink}" alt="${name}">
                            <h5>${name}</h5>
                            <p class="price">${price}₫</p>
                            <button class="btn btn-primary" onclick="addToOrder('${name}', ${price})">Order</button>
                        </div>
                    </c:if>
                </c:forEach>
                <!-- Add more menu items similarly -->
            </div>
        </div>
        <% 
            // Kiểm tra nếu tableID đã được truyền vào
            String tableID = request.getParameter("tableID");
            if (tableID != null) {
                session.setAttribute("tableID", tableID);
            }
        %>
        <!--footer-->
        <%@include file="footer.jsp" %>
        <script src="js/order.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
