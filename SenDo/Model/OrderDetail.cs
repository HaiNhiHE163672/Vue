namespace SenDo.Model
{
    public class OrderDetail
    {
        public int Id { get; set; }
        public double PriceTotal { get; set; }
        public int Quantity { get; set; }
        public int OrderId { get; set; }
        public Product Product { get; set; }
    }
}
