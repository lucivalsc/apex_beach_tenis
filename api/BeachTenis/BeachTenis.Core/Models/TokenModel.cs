using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Core.Models
{
    public class TokenModel
    {
        [Required(ErrorMessage = "Token é obrigatório")]
        public string? AccessToken { get; set; }

        [Required(ErrorMessage = "RefreshToken é obrigatório")]
        public string? RefreshToken { get; set; }
    }
}
