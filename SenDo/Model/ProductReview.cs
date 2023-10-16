namespace SenDo.Model
{
    public class ProductReview
    {
        public int ProductReviewId { get; set; }
        public string ContentReview { get; set; }
        public int PointEvaluation { get; set; }
        public int ProductId { get; set; }
        public Product Product { get; set; }
    }
}
