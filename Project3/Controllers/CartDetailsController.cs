﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Project3.Models;

namespace Project3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CartDetailsController : ControllerBase
    {
        private readonly DatabaseContext _context;

        public CartDetailsController(DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/CartDetails
        [HttpGet]
        public async Task<ActionResult<IEnumerable<CartDetail>>> GetCartDetails()
        {
          if (_context.CartDetails == null)
          {
              return NotFound();
          }
            return await _context.CartDetails.ToListAsync();
        }

        // GET: api/CartDetails/5
        [HttpGet("{id}")]
        public async Task<ActionResult<CartDetail>> GetCartDetail(int id)
        {
          if (_context.CartDetails == null)
          {
              return NotFound();
          }
            var cartDetail = await _context.CartDetails.FindAsync(id);

            if (cartDetail == null)
            {
                return NotFound();
            }

            return cartDetail;
        }

        // PUT: api/CartDetails/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutCartDetail(int id, CartDetail cartDetail)
        {
            if (id != cartDetail.Id)
            {
                return BadRequest();
            }

            _context.Entry(cartDetail).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CartDetailExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/CartDetails
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<CartDetail>> PostCartDetail(CartDetail cartDetail)
        {
          if (_context.CartDetails == null)
          {
              return Problem("Entity set 'DatabaseContext.CartDetails'  is null.");
          }
            _context.CartDetails.Add(cartDetail);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetCartDetail", new { id = cartDetail.Id }, cartDetail);
        }

        // DELETE: api/CartDetails/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCartDetail(int id)
        {
            if (_context.CartDetails == null)
            {
                return NotFound();
            }
            var cartDetail = await _context.CartDetails.FindAsync(id);
            if (cartDetail == null)
            {
                return NotFound();
            }

            _context.CartDetails.Remove(cartDetail);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool CartDetailExists(int id)
        {
            return (_context.CartDetails?.Any(e => e.Id == id)).GetValueOrDefault();
        }
    }
}
