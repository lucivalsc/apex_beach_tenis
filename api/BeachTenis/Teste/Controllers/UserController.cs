using BeachTenis.Core.Entidades;
using BeachTenis.Core.Interfaces.Services;
using Microsoft.AspNetCore.Mvc;

namespace Teste.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
        "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;

        public UserController(ILogger<WeatherForecastController> logger, IUserService userService)
        {
            _logger = logger;
            _userService = userService;
        }
        private readonly IUserService _userService;

        //[HttpGet]
        //public async Task<IActionResult> GetAllUsers()
        //{
        //    var users = await _userService.GetAllUsersAsync();
        //    return Ok(users);
        //}

        [HttpGet(Name = "GetWeatherForecastNome")]
        public IEnumerable<WeatherForecast> GetNome(string nome)
        {
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateTime.Now.AddDays(index),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
