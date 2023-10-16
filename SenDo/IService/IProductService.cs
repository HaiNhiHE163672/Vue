using Microsoft.AspNetCore.Mvc;
using SenDo.Model;
using SenDo.Page;

namespace SenDo.IService
{
    public interface IProductService
    {
        public PageResult<Product> GetProducts(Pagination pagination, string? search = null, int? typeId = null);
        public Product ProductGetProductById(int id);
        public List<ProductType> GetProductTypes();
        public string AddToCart(Cart cart);
        public int QuantityCart();
        public List<Cart> GetCarts();
        public int UpdateCart(Cart cart);
        public string DeleteCart(int id);
    }
}
