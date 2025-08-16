using BeachTenis.Core.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Application.DTOs
{
    public class UserDto
    {
        public Guid Id { get; private set; }
        public string? Name { get; set; }
        public DateTime BirthDate { get; set; }
        public string? Sex { get; set; }
        public string? Email { get; set; }
        public string? CPF { get; set; }
        public string? RG { get; set; }
        public string? Telephone { get; set; }
        public bool YesWhatsapp { get; set; } = true;
        public string? Photograph { get; set; }
        public int IdArena { get; set; }
        public string? Instagram { get; set; }
        public string? Facebook { get; set; }
        public string? Address { get; set; }
        public int IdProfessional { get; set; }
        public UserTypeEnum UserType { get; set; }
        public ProviderEnum Provider { get; private set; } = 0;
        public string? PhotoUrlProvider { get; set; }

    }
}
