namespace SenDo.Model
{
    public class ProductImage
    {
        public int ProductImageId { get; set; }
        public string ProductImageName { get; set;}
        public string ProductImageLink{ get; set;}
        public int ProductId { get; set;}
        public Product Product { get; set;}
    }
}
