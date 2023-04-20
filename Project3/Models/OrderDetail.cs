﻿using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Project3.Models
{
    [Table("orderdeails")]
    public class OrderDetail
        {
            public int Id { get; set; }
            [Required]
            public int OrderId { get; set; }
            [Required]
            public int ProductId { get; set; }
            [Required]
            public int Quantity { get; set; }
            [Required]
            public decimal Price { get; set; }
            public DateTime CreatedAt { get; set; }
            public DateTime UpdatedAt { get; set; }
            public Order Order { get; set; }
            public Product Product { get; set; }
        }
    

}
