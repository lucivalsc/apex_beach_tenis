using BeachTenis.Application.Services;
using BeachTenis.Core.Entidades;
using BeachTenis.Core.Enums;
using BeachTenis.Core.Interfaces.Services;
using BeachTenis.Core.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using System.Security.Authentication;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Identity;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using AutoMapper;
using BeachTenis.Application.DTOs;

namespace BeachTenis.API.Controllers
{
    [ApiController]
    [Route("api/user")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;
        private readonly ILogger<UserController> _logger;
        private readonly IAuthService _authService;
        private readonly IConfiguration _configuration;
        private readonly IMapper _mapper;
        public UserController(ILogger<UserController> logger,
                              IUserService userService, 
                              IAuthService authService, 
                              IConfiguration configuration,
                              IMapper mapper)
        {
            _logger = logger;
            _userService = userService;
            _authService = authService;
            _configuration = configuration;
            _mapper = mapper;
        }


        /// <summary>
        /// Consulta todos os usuarios
        /// </summary>
        /// <returns></returns>
        [Authorize]
        [HttpGet]
        public async Task<IActionResult> GetAllUsers()
        {
            try
            {
                var users = await _userService.GetAllUsersAsync();
                var userDtos = _mapper.Map<IEnumerable<UserDto>>(users);
                return Ok(userDtos);
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while list the users.");
            }
        }

        /// <summary>
        /// Consulta usuario por ID
        /// </summary>
        /// <param name="userId">Usuario cadastrado por ID (GUID)</param>
        /// <returns></returns>
        [Authorize]
        [HttpGet("{userId}")]
        public async Task<IActionResult> GetUserById(Guid userId)
        {
            try
            {
                var user = await _userService.GetUserByIdAsync(userId);
                if (user == null)
                    return NotFound();


                var userDto = _mapper.Map<UserDto>(user);

                return Ok(userDto);
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while list the user.");
            }
        }

        [HttpPost]
        [Route("create")]
        public async Task<IActionResult> CreateUser([FromBody] User user)
        {
            try
            {
                var userSearch = await _userService.GetByEmailPasswordAsync(user.Email);

                var userExiste = userSearch is not null;

                if (!user.IsModelValid(userExiste) || !ModelState.IsValid)
                {
                    ModelState.AddModelError(string.Empty, user.Erro);
                    return BadRequest(ModelState);
                }

                user.BirthDate = DateTime.SpecifyKind(user.BirthDate, DateTimeKind.Utc);

                var userId = await _userService.CreateUserAsync(user);

                if (userId == null || userId == Guid.Empty)
                {
                    return BadRequest("Failed to create the user.");
                }

                var userDto = _mapper.Map<UserDto>(user);

                return CreatedAtAction(nameof(GetUserById), new { userId }, userDto);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while creating the user.");
                return BadRequest("An error occurred while creating the user." + ex.Message);
            }
        }

        [HttpPost]
        [Route("create/facebook")]
        public async Task<IActionResult> CreateUserFacebook([FromBody] User user)
        {
            try
            {
                var userSearch = await _userService.GetByEmailPasswordAsync(user.Email);

                var userExiste = userSearch is not null;

                if (!user.IsModelValid(userExiste, Core.Enums.ProviderEnum.Facebook) || !ModelState.IsValid)
                {
                    ModelState.AddModelError(string.Empty, user.Erro);
                    return BadRequest(ModelState);
                }

                user.BirthDate = DateTime.SpecifyKind(user.BirthDate, DateTimeKind.Utc);


                var userId = await _userService.CreateUserAsync(user);

                var userDto = _mapper.Map<UserDto>(user);

                return CreatedAtAction(nameof(GetUserById), new { userId }, userDto);
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while creating the user.");
            }
        }

        [HttpPost]
        [Route("create/google")]
        public async Task<IActionResult> CreateUserGoogle([FromBody] User user)
        {
            try
            {
                var userSearch = await _userService.GetByEmailPasswordAsync(user.Email);

                var userExiste = userSearch is not null;

                if (!user.IsModelValid(userExiste, Core.Enums.ProviderEnum.Google) || !ModelState.IsValid)
                {
                    ModelState.AddModelError(string.Empty, user.Erro);
                    return BadRequest(ModelState);
                }

                user.BirthDate = DateTime.SpecifyKind(user.BirthDate, DateTimeKind.Utc);
                var userId = await _userService.CreateUserAsync(user);

                var userDto = _mapper.Map<UserDto>(user);

                return CreatedAtAction(nameof(GetUserById), new { userId }, userDto);
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while creating the user.");
            }
        }

        [Authorize]
        [HttpPut("{userId}")]
        public async Task<IActionResult> UpdateUser(Guid userId, [FromBody] User user)
        {
            try
            {
                var existingUser = await _userService.GetUserByIdAsync(userId);
                if (existingUser == null)
                    return NotFound();


                if (!user.IsModelValid(false, user.Provider) || !ModelState.IsValid)
                {
                    ModelState.AddModelError(string.Empty, user.Erro);
                    return BadRequest(ModelState);
                }

                user.BirthDate = DateTime.SpecifyKind(user.BirthDate, DateTimeKind.Utc);
                user.AlterChangeDate();
                await _userService.UpdateUserAsync(user);
                return NoContent();
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while update the user.");
            }

        }

        [Authorize]
        [HttpDelete("{userId}")]
        public async Task<IActionResult> DeleteUser(Guid userId)
        {
            try
            {
                var existingUser = await _userService.GetUserByIdAsync(userId);
                if (existingUser == null)
                    return NotFound();

                existingUser.AlterStatus();
                await _userService.UpdateUserAsync(existingUser);
                return NoContent();
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while delete the user.");
            }
        }


        [HttpPost]
        [Route("login")]
        public async Task<IActionResult> Login([FromBody] LoginModel loginModel)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var user = await _userService.GetByEmailPasswordAsync(loginModel.Email);
                loginModel.EncryptPassword();

                if ((user == null || user.Password != loginModel.Password))
                    return Unauthorized("Usuario ou senha não invalido");

                var token = _authService.GenerateJwtToken(user);
                var refreshToken = _authService.GenerateRefreshToken();

                return Ok(new
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(token),
                    RefreshToken = refreshToken,
                    Expiration = token.ValidTo
                });
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while processing the login request.");
            }
        }


        [HttpPost]
        [Route("login/google")]
        public async Task<IActionResult> LoginGoogle([FromBody] LoginSocialModel loginModel)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var user = await _userService.GetByEmailPasswordAsync(loginModel.Email);

                if (user == null || user.IdUserProvider != loginModel.IdProvider)
                    return Unauthorized("Usuario invalido");

                var token = _authService.GenerateJwtToken(user);
                var refreshToken = _authService.GenerateRefreshToken();

                return Ok(new
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(token),
                    RefreshToken = refreshToken,
                    Expiration = token.ValidTo
                });
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while processing the login request.");
            }
        }

        [HttpPost]
        [Route("login/facebook")]
        public async Task<IActionResult> LoginFacebook([FromBody] LoginSocialModel loginModel)
        {
            try
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                var user = await _userService.GetByEmailPasswordAsync(loginModel.Email);

                if (user == null || user.IdUserProvider != loginModel.IdProvider)
                    return Unauthorized("Usuario invalido");

                var token = _authService.GenerateJwtToken(user);
                var refreshToken = _authService.GenerateRefreshToken();

                return Ok(new
                {
                    Token = new JwtSecurityTokenHandler().WriteToken(token),
                    RefreshToken = refreshToken,
                    Expiration = token.ValidTo
                });
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while processing the login request.");
            }
        }


        [HttpPost]
        [Route("refresh-token")]
        public async Task<IActionResult> RefreshToken(TokenModel tokenModel)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            string? accessToken = tokenModel.AccessToken;
            string? refreshToken = tokenModel.RefreshToken;

            var principal = GetPrincipalFromExpiredToken(accessToken);
            if (principal == null)
            {
                return BadRequest("Invalid access token/refresh token");
            }

            string username = principal.Identity.Name;

            var user = await _userService.GetByEmailPasswordAsync(username);

            if (user == null)
            {
                return BadRequest("Invalid access token/refresh token");
            }

            var newAccessToken = _authService.GenerateJwtToken(user);
            var newRefreshToken = _authService.GenerateRefreshToken();

            return new ObjectResult(new
            {
                accessToken = new JwtSecurityTokenHandler().WriteToken(newAccessToken),
                refreshToken = newRefreshToken
            });
        }
        private ClaimsPrincipal? GetPrincipalFromExpiredToken(string? token)
        {
            var tokenValidationParameters = new TokenValidationParameters
            {
                ValidateAudience = false,
                ValidateIssuer = false,
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:SecretKey"])),
                ValidateLifetime = false
            };

            var tokenHandler = new JwtSecurityTokenHandler();

            var principal = tokenHandler.ValidateToken(token, tokenValidationParameters, out SecurityToken securityToken);

            if (securityToken is not JwtSecurityToken jwtSecurityToken || !jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256, StringComparison.InvariantCultureIgnoreCase))
                throw new SecurityTokenException("Invalid token");

            return principal;
        }
        [HttpPost]
        [Authorize]
        [Route("logout")]
        public async Task<IActionResult> Logout()
        {
            try
            {
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);

                return Ok("Logout successful");
            }
            catch (Exception ex)
            {
                return BadRequest("An error occurred while processing the logout request.");
            }
        }
    }
}