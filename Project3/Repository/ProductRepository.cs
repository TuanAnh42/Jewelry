using Microsoft.EntityFrameworkCore;
using Project3.Interface;
using Project3.Models;

namespace Project3.Repository
{
    public class ProductRepository : IProductRepository
    {
       
            private readonly DatabaseContext _dbContext;

            public ProductRepository(DatabaseContext dbContext)
            {
                _dbContext = dbContext;
            }
            
            public async Task<List<Product>> GetAllProductsAsync()
            {
            return await _dbContext.Products.ToListAsync();
            }

            public async Task<Product> GetProductByIdAsync(int id)
            {
                return await _dbContext.Products.FindAsync(id);
            }
            public IEnumerable<Product> GetProductsByPriceRange(decimal minPrice, decimal maxPrice)
            {
                return _dbContext.Products.Where(p => p.Price >= minPrice && p.Price <= maxPrice).ToList();
            }

        public async Task<Product> CreateProductAsync(Product product)
            {
                _dbContext.Products.Add(product);
                await _dbContext.SaveChangesAsync();
                return product;
            }

            public async Task<Product> UpdateProductAsync(int id, Product product)
            {
                var existingProduct = await _dbContext.Products.FindAsync(id);
                if (existingProduct == null)
                {
                    return null;
                }

                existingProduct.Name = product.Name;
                existingProduct.Description = product.Description;
                existingProduct.Price = product.Price;
                existingProduct.ImageUrl = product.ImageUrl;
                existingProduct.CategoryId = product.CategoryId;
                existingProduct.BrandId = product.BrandId;
                existingProduct.PromotionId = product.PromotionId;
                existingProduct.UpdatedAt = DateTime.UtcNow;

                await _dbContext.SaveChangesAsync();

                return existingProduct;
            }

            public async Task DeleteProductAsync(int id)
            {
                var existingProduct = await _dbContext.Products.FindAsync(id);
                if (existingProduct == null)
                {
                    return;
                }

                _dbContext.Products.Remove(existingProduct);
                await _dbContext.SaveChangesAsync();
            }
        }

    
}
