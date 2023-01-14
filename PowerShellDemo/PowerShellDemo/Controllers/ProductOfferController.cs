using Microsoft.AspNetCore.Mvc;
using PowerShellDemo.Entities;
using PowerShellDemo.Repositories;

namespace PowerShellDemo.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductOfferController : ControllerBase
    {
        private readonly IProductOfferService productOfferService;

        public ProductOfferController(IProductOfferService productOfferService)
        {
            this.productOfferService = productOfferService;
        }

        [HttpGet("getofferlist")]
        public async Task<List<Offer>> GetOfferListAsync()
        {
            try
            {
                var response = await productOfferService.GetOfferListAsync();

                return response;
            }
            catch
            {

            }
            return null;
        }

        [HttpGet("getofferbyid")]
        public async Task<Offer> GetOfferByIdAsync(int Id)
        {
            try
            {
                var response = await productOfferService.GetOfferByIdAsync(Id);

                return response;
            }
            catch
            {

            }
            return null;
        }

        [HttpPost("addoffer")]
        public async Task<Offer> AddOfferAsync(Offer offer)
        {
            try
            {
                var response = await productOfferService.AddOfferAsync(offer);

                return response;
            }
            catch
            {

            }
            return null;
        }

        [HttpPut("updateoffer")]
        public async Task<Offer> UpdateOfferAsync(Offer offer)
        {
            try
            {
                var response = await productOfferService.UpdateOfferAsync(offer);

                return response;
            }
            catch
            {

            }
            return null;
        }

        [HttpDelete("deleteoffer")]
        public async Task<bool> DeleteOfferAsync(int Id)
        {
            try
            {
                var response = await productOfferService.DeleteOfferAsync(Id);
                return response;
            }
            catch
            {

            }
            return false;
        }
    }
}
