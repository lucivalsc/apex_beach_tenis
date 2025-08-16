using BeachTenis.Core.Entidades;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Infrastructure.Configurations
{
    public class ArenaConfiguration : IEntityTypeConfiguration<Arena>
    {
        public void Configure(EntityTypeBuilder<Arena> builder)
        {
            builder.ToTable("Arena");

            builder.HasKey(t => t.Id);

            builder.Property(u => u.Name)
                    .HasColumnName("nome")
                    .HasMaxLength(30)
                    .IsRequired();

            builder.Property(u => u.Email)
                    .HasColumnName("email")
                    .HasMaxLength(50)
                    .IsRequired();

            builder.Property(u => u.CNPJ)
                   .HasColumnName("cnpj")
                   .HasMaxLength(14);

            builder.Property(u => u.Telephone)
                    .HasColumnName("telefone")
                    .HasMaxLength(11);

            builder.Property(u => u.YesWhatsapp)
                    .HasColumnName("ehWhatsapp");

            builder.Property(u => u.Photograph)
                    .HasColumnName("foto")
                    .HasMaxLength(1000);


            builder.Property(u => u.Instagram)
                    .HasColumnName("instagram")
                    .HasMaxLength(50);

            builder.Property(u => u.Facebook)
                    .HasColumnName("facebook")
                    .HasMaxLength(50);

            builder.Property(u => u.Address)
                    .HasColumnName("endereco")
                    .HasMaxLength(200);

        }
    }
}
