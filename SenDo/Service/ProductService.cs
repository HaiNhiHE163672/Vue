using Microsoft.EntityFrameworkCore;
using SenDo.IService;
using SenDo.Model;
using SenDo.Page;

namespace SenDo.Service
{
    public class ProductService : IProductService
    {
        private readonly AppDbContext DbContext;
        public ProductService()
        {
            DbContext = new AppDbContext();
        }

        public string AddToCart(Cart cart)
        {
            if(DbContext.Products.Any(x => x.ProductId == cart.ProductId))
            {
                if (DbContext.Carts.Any(x => x.ProductId == cart.ProductId))
                {
                    var ca = DbContext.Carts.Find(cart.ProductId);
                    ca.Quantity += cart.Quantity;
                    DbContext.Update(ca);
                    DbContext.SaveChanges();
                }
                else
                {
                    DbContext.Add(cart);
                    DbContext.SaveChanges();
                }
                
                
                return "Thêm vào giỏ hàng thành công!";
            }
            else
            {
                return"Sản phẩm không tồn tại";
            }
        }

        public string DeleteCart(int id)
        {
            var cart = DbContext.Carts.Find(id);
            DbContext.Remove(cart);
            DbContext.SaveChanges();
            return "Xóa sản phẩm khỏi giỏ hàng thành công!";
        }

        public List<Cart> GetCarts()
        {
            return DbContext.Carts.Include(x => x.Product).ThenInclude(x => x.Shop).ToList();
        }

        public PageResult<Product> GetProducts(Pagination pagination, string? search = null, int? typeId = null)
        {
            var list = DbContext.Products.Include(x => x.ProductType).Include(x => x.Shop).ToList();
            if (search != null)
            {
                list = list.Where(x => x.ProductName.Contains(search)).ToList();
            }
            if(typeId != null)
            {
                list = list.Where(x => x.ProductTypeId == typeId).ToList();
            }
            var res = PageResult<Product>.ToPageResult(pagination, list);
            pagination.TotalCount = list.Count;
            return new PageResult<Product>(pagination, res);
        }

        public List<ProductType> GetProductTypes()
        {
            return DbContext.ProductTypes.Include(x => x.Products).ToList();
        }

        public Product ProductGetProductById(int id)
        {
            if(DbContext.Products.Any(x => x.ProductId == id))
            {
                var product = DbContext.Products.Include(x => x.Shop).FirstOrDefault(x => x.ProductId == id);
                return product;
            }
            else
            {
                throw new Exception("Sản phẩm không tồn tại!");
            }
        }

        public int QuantityCart()
        {
            int total = DbContext.Carts.Sum(x => x.Quantity);   
            return total;
        }

        public int UpdateCart(Cart cart)
        {
            int total = DbContext.Carts.Sum(x => x.Quantity);
            if(DbContext.Carts.Any(x => x.CartId == cart.CartId))
            {
                var ca = DbContext.Carts.Find(cart.CartId);
                ca.Quantity = cart.Quantity;
                DbContext.Update(ca);
                DbContext.SaveChanges();
                total = DbContext.Carts.Sum(x => x.Quantity);
            }
            return total;
        }
    }
}
