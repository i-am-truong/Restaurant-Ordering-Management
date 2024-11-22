/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ADMIN
 */
public class OrderDetailDAO extends DBContext {

    public List<OrderDetail> getOrderDetailsByTableId(int tableId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = """
                     select od.OrderDetailID, od.OrderID, o.TableID, od.DishID, 
                     	    d.DishName, od.Quantity, od.Price, od.Status, o.OrderTime, o.OrderStatus
                                          from [Order] o 
                                          join OrderDetail od on o.OrderID = od.OrderID
                                          join Dish d on d.DishID = od.DishID
                                          where o.TableID =  ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, tableId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderDetailId(rs.getInt("OrderDetailID"));
                od.setOrderId(rs.getInt("OrderID"));
                od.setTableId(rs.getInt("TableID"));
                od.setDishId(rs.getInt("DishID"));
                od.setDishName(rs.getString("DishName"));
                od.setQuantity(rs.getInt("Quantity"));
                od.setPrice(rs.getInt("Price"));
                od.setStatus(rs.getString("Status"));
                od.setOrderTime(rs.getTimestamp("OrderTime").toLocalDateTime());
                od.setOrderStatus(rs.getString("OrderStatus"));
                if ("Not Yet".equals(od.getOrderStatus())) {
                    orderDetails.add(od);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return orderDetails;
    }

    public void confirm(int dishId, int orderId) {
        String sql = """
                     update [OrderDetail]
                     set Status = 'Served'
                     where DishID = ? and OrderID = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, dishId);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateStatus(int dishId, int orderId) {
        String sql = """
                     update [OrderDetail]
                     set Status = 'Not Served'
                     where DishID = ? and OrderID = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, dishId);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
