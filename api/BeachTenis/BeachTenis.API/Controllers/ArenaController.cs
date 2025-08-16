using AutoMapper;
using BeachTenis.Application.DTOs;
using BeachTenis.Application.Services;
using BeachTenis.Core.Entidades;
using BeachTenis.Core.Interfaces.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace BeachTenis.API.Controllers
{
    [ApiController]
    [Route("api/arena")]
    public class ArenaController : ControllerBase
    {
        private readonly IArenaService _arenaService;
        private readonly ILogger<ArenaController> _logger;
        private readonly IAuthService _authService;
        private readonly IConfiguration _configuration;
        private readonly IMapper _mapper;
        public ArenaController(ILogger<ArenaController> logger,
                              IArenaService arenaService)
        {
            _logger = logger;
            _arenaService = arenaService;
        }

        /// <summary>
        /// Consulta todos os arenas
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpGet]
        public async Task<IActionResult> GetAllArenass()
        {
            try
            {
                var arenas = await _arenaService.GetAllArenassAsync();

                return Ok(arenas);
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while list the arenas.");
            }
        }

        /// <summary>
        /// Consulta arena por ID
        /// </summary>
        /// <param name="arenaId">Usuario cadastrado por ID (GUID)</param>
        /// <returns></returns>
        [Authorize]
        [HttpGet("{arenaId}")]
        public async Task<IActionResult> GetArenaById(Guid arenaId)
        {
            try
            {
                var user = await _arenaService.GetArenaByIdAsync(arenaId);
                if (user == null)
                    return NotFound();


                var userDto = _mapper.Map<UserDto>(user);

                return Ok(userDto);
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while list the arenas.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> CreateArena([FromBody] Arena arena)
        {
            try
            {
                var arenaSearch = await _arenaService.GetByEmailAsync(arena.Email);

                var userExiste = arenaSearch is not null;

                if (!ModelState.IsValid)
                {
                    //ModelState.AddModelError(string.Empty, user.Erro);
                    return BadRequest(ModelState);
                }

                var arenaId = await _arenaService.CreateArenaAsync(arena);

                if (arenaId == null || arenaId == Guid.Empty)
                {
                    return BadRequest("Failed to create the arena.");
                }

                return CreatedAtAction(nameof(GetArenaById), new { arenaId }, arena);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating the arena.");
                return BadRequest("An error occurred while creating the arena." + ex.Message);
            }
        }

        [Authorize]
        [HttpPut("{arenaId}")]
        public async Task<IActionResult> UpdateArena(Guid arenaId, [FromBody] Arena arena)
        {
            try
            {
                var existingArena = await _arenaService.GetArenaByIdAsync(arenaId);
                if (existingArena == null)
                    return NotFound();


                if (!ModelState.IsValid)
                {
                    //ModelState.AddModelError(string.Empty, user.Erro);
                    return BadRequest(ModelState);
                }

                await _arenaService.UpdateArenaAsync(arena);
                return NoContent();
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while update the arena.");
            }

        }

        [Authorize]
        [HttpDelete("{arenaId}")]
        public async Task<IActionResult> DeleteArena(Guid arenaId)
        {
            try
            {
                var existingArena = await _arenaService.GetArenaByIdAsync(arenaId);
                if (existingArena == null)
                    return NotFound();

                existingArena.AlterStatus();
                await _arenaService.UpdateArenaAsync(existingArena);
                return NoContent();
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while delete the arena.");
            }
        }
    }
}
