using SenDo.Model;

namespace SenDo.IService
{
    public interface IOrderService
    {
        public List<OrderDetail> GetOrderDetails();
        public List<Order> GetOrders();
        public Order OrderById (int id);
    }
}
