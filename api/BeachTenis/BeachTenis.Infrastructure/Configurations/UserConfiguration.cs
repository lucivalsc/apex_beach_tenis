using BeachTenis.Core.Entidades;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Infrastructure.Configurations
{
    public class UserConfiguration : IEntityTypeConfiguration<User>
    {
        public void Configure(EntityTypeBuilder<User> builder)
        {
            builder.ToTable("Usuario");

            builder.HasKey(t => t.Id);

            builder.Property(u => u.Name)
                    .HasColumnName("nome")
                    .HasMaxLength(30)
                    .IsRequired();

            builder.Property(u => u.BirthDate)
                   .HasColumnName("dataNascimento");

            builder.Property(u => u.Sex)
                   .HasColumnName("sexo")
                   .HasMaxLength(20);

            builder.Property(u => u.Email)
                    .HasColumnName("email")
                    .HasMaxLength(50)
                    .IsRequired();

            builder.Property(u => u.CPF)
                   .HasColumnName("cpf")
                   .HasMaxLength(14);

            builder.Property(u => u.RG)
                    .HasColumnName("rg")
                    .HasMaxLength(14);

            builder.Property(u => u.Telephone)
                    .HasColumnName("telefone")
                    .HasMaxLength(11);

            builder.Property(u => u.YesWhatsapp)
                    .HasColumnName("ehWhatsapp");

            builder.Property(u => u.Photograph)
                    .HasColumnName("foto")
                    .HasMaxLength(1000);

            builder.Property(u => u.IdArena)
                    .HasColumnName("idArena");

            builder.Property(u => u.Instagram)
                    .HasColumnName("instagram")
                    .HasMaxLength(50);

            builder.Property(u => u.Facebook)
                    .HasColumnName("facebook")
                    .HasMaxLength(50);

            builder.Property(u => u.Address)
                    .HasColumnName("endereco")
                    .HasMaxLength(200);

            builder.Property(u => u.IdProfessional)
                    .HasColumnName("idProfessional");

            builder.Property(u => u.UserType)
                    .HasColumnName("tipoUsuario");

            builder.Property(u => u.Provider)
                    .HasColumnName("loginRedeSocial");

            builder.Property(u => u.IdUserProvider)
                    .HasColumnName("idLoginRedeSocial")
                    .HasMaxLength(50);

            builder.Property(u => u.PhotoUrlProvider)
                    .HasColumnName("fotoLoginRedeSocial")
                    .HasMaxLength(50);

            builder.Property(u => u.Password)
                    .HasColumnName("senha")
                    .HasMaxLength(50);

            builder.Property(u => u.Code)
                    .HasColumnName("codigo")
                    .HasMaxLength(6);
        }
    }
}
