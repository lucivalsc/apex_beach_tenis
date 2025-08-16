using BeachTenis.Core.Enums;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace BeachTenis.Core.Models
{
    public class LoginModel
    {
        [EmailAddress(ErrorMessage = "Endereço de email invalido")]
        public string? Email { get; set; }
        public string? Password { get; set; }
        public void EncryptPassword()
        {
            if (!string.IsNullOrEmpty(Password))
            {
                using (SHA256 sha256 = SHA256.Create())
                {
                    byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(Password));
                    Password = Convert.ToBase64String(hashedBytes);
                }
            }
        }
    }
}
