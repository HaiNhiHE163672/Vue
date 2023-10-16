namespace SenDo.Model
{
    public class Properties
    {
        public int Id { get; set; }
        public string PropertyName { get; set; }
        public int ProductId { get; set; }
        public Product Product { get; set; }
    }
}
