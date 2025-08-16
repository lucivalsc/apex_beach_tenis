using BeachTenis.Core.Enums;
using System.ComponentModel.DataAnnotations;

namespace BeachTenis.Core.Entidades
{
    public class Arena : BaseEntity
    {
        [Required(ErrorMessage = "Nome é obrigatório")]
        [StringLength(30, MinimumLength = 4, ErrorMessage = "O nome deve ter entre 3 e 30 caracteres")]
        public string? Name { get; set; } = "";
        public string? Address { get; set; } = string.Empty;

        [RegularExpression(@"^\d+$", ErrorMessage = "O CNPJ deve conter apenas caracteres numéricos")]
        [StringLength(11, MinimumLength = 10, ErrorMessage = "O nome deve ter entre 0 e 11 caracteres")]
        public string? CNPJ { get; set; } = string.Empty;
        public string? Telephone { get; set; } = string.Empty;
        public bool YesWhatsapp { get; set; } = true;

        [EmailAddress(ErrorMessage = "Endereço de email invalido")]
        public string? Email { get; set; } = string.Empty;
        public string? Instagram { get; set; } = string.Empty;
        public string? Facebook { get; set; } = string.Empty;
        public string? Photograph { get; set; } = string.Empty;
    }
}
