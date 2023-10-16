namespace SenDo.Model
{
    public class Order
    {
        public int OrderId { get; set; }
        public double OrginalPrice { get; set; }
        public double ActualPrice { get; set; }
        public int Quantity { get; set; }
        public List<OrderDetail> Details { get;set; }
    }
}
