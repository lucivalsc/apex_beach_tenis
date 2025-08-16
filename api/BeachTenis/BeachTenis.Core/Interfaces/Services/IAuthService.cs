using BeachTenis.Core.Entidades;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Core.Interfaces.Services
{
    public interface IAuthService
    {
        JwtSecurityToken GenerateJwtToken(User user);
        string GenerateRefreshToken();
    }
}
