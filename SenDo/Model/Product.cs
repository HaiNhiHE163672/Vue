namespace SenDo.Model
{
    public class Product
    {
        public int ProductId { get; set; }
        public int ProductTypeId { get; set; }
        public string ProductName { get; set; }
        public double Price { get; set; }
        public int? Discount { get; set; }
        public int Quantity { get; set; }
        public string AvartarImage { get; set; }
        public string Brand { get; set; }
        public int ShopId { get; set; }
        public List<ProductImage> Images { get; set; }
        public List<ProductReview> Reviews { get; set; }
        public List<OrderDetail> orderDetails { get; set; }
        public ProductType ProductType { get; set; }
        public Shop Shop { get; set; }
    }
}
