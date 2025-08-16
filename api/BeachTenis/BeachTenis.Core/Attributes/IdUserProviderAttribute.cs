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
    public sealed class IdUserProviderAttribute : ValidationAttribute
    {
        private const string DefaultErrorMessage = "O ID do cadastro da rede social é obrigatorio.";

        public override bool IsValid(object value)
        {
            if (!(value is User user))
            {
                return false;
            }

            return user.Provider > 0 && string.IsNullOrWhiteSpace(user.IdUserProvider);
        }

        public IdUserProviderAttribute() : base(DefaultErrorMessage) { }
    }

}
