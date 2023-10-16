namespace SenDo.Model
{
    public class ProductType
    {
        public int ProductTypeId { get; set; }
        public string ProductTypeName { get; set; }
        public List<Product> Products { get; set; }
        
    }
}
