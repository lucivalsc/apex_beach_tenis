using BeachTenis.Core.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace BeachTenis.Core.Models
{
    public class LoginSocialModel
    {
        [EmailAddress(ErrorMessage = "Endereço de email invalido")]
        public string? Email { get; set; }

        [Required(ErrorMessage = "Id do social é obrigatório")]
        public string? IdProvider { get; set; }

    }
}
