using SenDo.IService;
using SenDo.Model;

namespace SenDo.Service
{
    public class OrderService : IOrderService
    {
        private readonly AppDbContext DbContext;
        public OrderService()
        {
            DbContext = new AppDbContext();
        }
        public List<OrderDetail> GetOrderDetails()
        {
           var list = DbContext.OrderDetails.ToList();
            return list;
        }

        public List<Order> GetOrders()
        {
            throw new NotImplementedException();
        }

        public Order OrderById(int id)
        {
            throw new NotImplementedException();
        }
    }
}
