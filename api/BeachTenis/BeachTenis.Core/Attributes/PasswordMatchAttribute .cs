using BeachTenis.Core.Entidades;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Core.Attributes
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false, Inherited = true)]
    public sealed class PasswordMatchAttribute : ValidationAttribute
    {
        private const string DefaultErrorMessage = "As senhas não coincidem.";

        public override bool IsValid(object value)
        {
            if (!(value is User user))
            {
                return false;
            }

            user.EncryptPassword();
            user.EncryptPasswordConfirm();
            return   user.Password == user.PasswordConfirm;
        }

        public PasswordMatchAttribute() : base(DefaultErrorMessage) { }
    }
}
