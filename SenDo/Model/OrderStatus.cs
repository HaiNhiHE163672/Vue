﻿namespace SenDo.Model
{
    public class OrderStatus
    {
        public int OrderStatusId { get; set; }
        public string StatusName { get; set; }
        public List<Order>? Orders { get; set; }
    }
}
