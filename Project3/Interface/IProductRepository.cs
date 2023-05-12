using Project3.Models;

namespace Project3.Interface
{
    public interface IProductRepository
    {
        Task<List<Product>> GetAllProductsAsync();
        Task<Product> GetProductByIdAsync(int id);
        IEnumerable<Product> GetProductsByPriceRange(decimal minPrice, decimal maxPrice);
        Task<Product> CreateProductAsync(Product product);
        Task<Product> UpdateProductAsync(int id, Product product);
        Task DeleteProductAsync(int id);
    }
}
