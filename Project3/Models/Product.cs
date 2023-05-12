using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace Project3.Models
{
    [Table("Products")]
    public class Product
    {
        [Column("id")]
        public int Id { get; set; }

        [Required(ErrorMessage = "Name is required")]
        [MaxLength(255, ErrorMessage = "Name cannot exceed 255 characters")]
        [Column("name")]
        public string? Name { get; set; }
        [Column("description")]

        public string? Description { get; set; }
        [Column("price")]

        [Required(ErrorMessage = "Price is required")]
        [Range(0.01, double.MaxValue, ErrorMessage = "Price must be greater than 0")]
        public decimal Price { get; set; }
        [Column("image_url")]

        public string? ImageUrl { get; set; }
        [Column("quantity")]

        public int? Quantity{ get; set; }
        [Column("category_id")]

        [Required(ErrorMessage = "Category is required")]
        public int CategoryId { get; set; }
        [Column("brand_id")]

        [Required(ErrorMessage = "Brand is required")]
        public int BrandId { get; set; }
        [Column("promotion_id")]

        public int? PromotionId { get; set; }
        [Column("created_at")]

        public DateTime? CreatedAt { get; set; }
        [Column("updated_at")]

        public DateTime? UpdatedAt { get; set; }


        public virtual Brand? Brand { get; set; }

        public virtual ICollection<CartDetail> CartDetails { get; set; } = new List<CartDetail>();
        public virtual Category? Category { get; set; }

        public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

        public virtual Promotion? Promotion { get; set; }

        public virtual ICollection<Promotion> Promotions { get; set; } = new List<Promotion>();
    }



}
