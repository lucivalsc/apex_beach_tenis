using BeachTenis.Core.Enums;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json.Serialization;

namespace BeachTenis.Core.Entidades
{
    public sealed class User : BaseEntity
    {

        [Required(ErrorMessage = "Nome é obrigatório")]
        [StringLength(30, MinimumLength = 4, ErrorMessage = "O nome deve ter entre 3 e 30 caracteres")]
        public string? Name { get; set; } = "";


        [Required(ErrorMessage = "Data de nascimento é obrigatório")]
        [DataType(DataType.Date)]
        public DateTime BirthDate { get; set; }
        public string? Sex { get; set; } = string.Empty;

        [EmailAddress(ErrorMessage = "Endereço de email invalido")]
        public string? Email { get; set; } = string.Empty;

        [RegularExpression(@"^\d+$", ErrorMessage = "O CPF deve conter apenas caracteres numéricos")]
        [StringLength(11, MinimumLength = 10, ErrorMessage = "O nome deve ter entre 0 e 11 caracteres")]
        public string? CPF { get; set; } = string.Empty;
        public string? RG { get; set; } = string.Empty;

        [RegularExpression(@"^\d+$", ErrorMessage = "O telefone deve conter apenas caracteres numéricos")]
        [StringLength(11, MinimumLength = 10, ErrorMessage = "O telefone deve deve ter entre 0 e 11 caracteres")]
        public string? Telephone { get; set; } = string.Empty;
        public bool YesWhatsapp { get; set; } = true;
        public string? Photograph { get; set; } = string.Empty;
        public int IdArena { get; set; }
        public string? Instagram { get; set; } = string.Empty;
        public string? Facebook { get; set; } = string.Empty;
        public string? Address { get; set; } = string.Empty;
        public int IdProfessional { get; set; }
        public UserTypeEnum UserType { get; set; }
        public ProviderEnum Provider { get; private set; } = 0;

        public string? IdUserProvider { get; set; } = string.Empty;
        public string? PhotoUrlProvider { get; set; } = string.Empty;


        [JsonIgnore]
        public string? Code { get; set; }

        
        public string? Password { get; set; } = string.Empty;

        [NotMapped]
        public string? PasswordConfirm { get; set; } = string.Empty;

        [NotMapped]
        public string? Erro { get; private set; }

        public void SetPorvider(ProviderEnum prov)
        {
            Provider = prov;
        }

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

        public void EncryptPasswordConfirm()
        {
            if (!string.IsNullOrEmpty(PasswordConfirm))
            {
                using (SHA256 sha256 = SHA256.Create())
                {
                    byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(PasswordConfirm));
                    PasswordConfirm = Convert.ToBase64String(hashedBytes);
                }
            }
        }

        public bool IsModelValid(bool existeUser =false, Core.Enums.ProviderEnum provider = 0 )
        {
            Erro = "";

            SetPorvider(provider);

            if (existeUser)
            {
                Erro = "Já existe usuário cadastrado com esse e-mail!";
                return false;
            }

            if (Provider == 0)
            {
                EncryptPassword();
                EncryptPasswordConfirm();

                if (string.IsNullOrWhiteSpace(Password) ||
                    string.IsNullOrWhiteSpace(PasswordConfirm) ||
                    Password != PasswordConfirm)
                {
                    Erro = "Senha e senha de confirmação são obrigatórias e devem ser iguais!";
                    return false;
                }

            }

            if (Provider > 0 && string.IsNullOrWhiteSpace(IdUserProvider))
            {
                Erro = "Para fazer o cadastro usando uma rede social, é necessario enviar o Id cadastrado na rede social informada!";
                return false;
            }
            return true;
        }
    }
}
