﻿namespace SenDo.Model
{
    public class Cart
    {
        public int CartId { get; set; }
        
        public int Quantity { get; set; }
        public int ProductId { get; set; }
        public Product? Product { get; set; }
    }
}
