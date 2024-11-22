/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author ADMIN
 */
public class OrderDAO extends DBContext {

    public void setOrderStatus(int tableId) {
        String sql = """
                     UPDATE [dbo].[Order]
                        SET [OrderStatus] = 'Done'
                      WHERE [TableID] = ?
                     """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, tableId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
