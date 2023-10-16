using Microsoft.AspNetCore.Mvc;
using SenDo.IService;
using SenDo.Model;
using SenDo.Page;
using SenDo.Service;

namespace SenDo.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly IProductService productService;
        public ProductController()
        {
            productService = new ProductService();
        }
        [HttpGet]
        public IActionResult ProductList([FromQuery]Pagination pagination, string? search, int? typeId)
        {
            var res = productService.GetProducts(pagination, search, typeId);
            return Ok(res);
        }
        [HttpGet("ListProductType")]
        public IActionResult TypeList()
        {
            var res = productService.GetProductTypes();
            return Ok(res);
        }
        [HttpGet("{id}")]
        public IActionResult GetProduct(int id)
        {
            var res = productService.ProductGetProductById(id);
            return Ok(res);
        }
        [HttpPost("AddtoCart")]
        public IActionResult AddToCart(Cart cart)
        {
            var res = productService.AddToCart(cart);
            return Ok(res);
        }
        [HttpGet("QuantityCart")]
        public IActionResult QuantityCart()
        {
            var res = productService.QuantityCart();
            return Ok(res);
        }
        [HttpGet("ListCart")]
        public IActionResult GetCarts()
        {
            var res = productService.GetCarts();
            return Ok(res);
        }
        [HttpPut("UpdateCart")]
        public IActionResult UpdateCart(Cart cart)
        {
            var res = productService.UpdateCart(cart);
            return Ok(res);
        }
        [HttpDelete("DeleteProduct")]
        public IActionResult DeleteProduct (int id)
        {
            var res = productService.DeleteCart(id);
            return Ok(res);
        }
    }
}
