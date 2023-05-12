using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Project3.Interface;
using Project3.Models;

namespace Project3.Repository
{
    public class OrderDetailRepository :IOrderDetailRepository
    {
        private readonly DatabaseContext _dbContext;
        public OrderDetailRepository(DatabaseContext context)
        {
            _dbContext = context;
        }
        public async Task<IEnumerable<OrderDetail>> GetOrderDetailsAsync(int orderId)
        {
            return await _dbContext.Set<OrderDetail>()
                .Where(o => o.OrderId == orderId)
                .ToListAsync();
        }
        [HttpGet("id")]
        // GET: api/Orders
        public async Task<OrderDetail> GetOrderDetailByIdAsync(int id)
        {
            return await _dbContext.Set<OrderDetail>().FindAsync(id);
        }

        public async Task<OrderDetail> CreateOrderDetailAsync(OrderDetail orderDetail)
        {
            var existingOrderDetail = _dbContext.OrderDetails
        .SingleOrDefault(od => od.OrderId == orderDetail.OrderId && od.ProductId == orderDetail.ProductId);

            if (existingOrderDetail != null)
            {
                existingOrderDetail.Quantity += orderDetail.Quantity;
                existingOrderDetail.Price = orderDetail.Price;
                existingOrderDetail.UpdatedAt = DateTime.Now;
            }
            else
            {
                await _dbContext.Set<OrderDetail>().AddAsync(orderDetail);
            }

           
            
            await _dbContext.SaveChangesAsync();
            return orderDetail;
        }

        public async Task<OrderDetail> UpdateOrderDetailAsync(int id, OrderDetail orderDetail)
        {
            var existingOrderDetail = await _dbContext.Set<OrderDetail>().FindAsync(id);

            if (existingOrderDetail == null)
            {
                return null;
            }

            existingOrderDetail.OrderId = orderDetail.OrderId;
            existingOrderDetail.ProductId = orderDetail.ProductId;
            existingOrderDetail.Quantity = orderDetail.Quantity;
            existingOrderDetail.Price = orderDetail.Price;

            _dbContext.Entry(existingOrderDetail).State = EntityState.Modified;
            await _dbContext.SaveChangesAsync();

            return existingOrderDetail;
        }

        public async Task DeleteOrderDetailAsync(int id)
        {
            var existingOrderDetail = await _dbContext.Set<OrderDetail>().FindAsync(id);

            if (existingOrderDetail != null)
            {
                _dbContext.Set<OrderDetail>().Remove(existingOrderDetail);
                await _dbContext.SaveChangesAsync();
            }
        }
    }
}
