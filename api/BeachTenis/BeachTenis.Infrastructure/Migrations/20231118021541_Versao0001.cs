using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BeachTenis.Infrastructure.Migrations
{
    public partial class Versao0001 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Usuario",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    nome = table.Column<string>(type: "character varying(30)", maxLength: 30, nullable: false),
                    dataNascimento = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    sexo = table.Column<string>(type: "character varying(20)", maxLength: 20, nullable: true),
                    email = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    cpf = table.Column<string>(type: "character varying(14)", maxLength: 14, nullable: true),
                    rg = table.Column<string>(type: "character varying(14)", maxLength: 14, nullable: true),
                    telefone = table.Column<string>(type: "character varying(11)", maxLength: 11, nullable: true),
                    ehWhatsapp = table.Column<bool>(type: "boolean", nullable: false),
                    foto = table.Column<string>(type: "character varying(1000)", maxLength: 1000, nullable: true),
                    idArena = table.Column<int>(type: "integer", nullable: false),
                    instagram = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    facebook = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    endereco = table.Column<string>(type: "character varying(200)", maxLength: 200, nullable: true),
                    idProfessional = table.Column<int>(type: "integer", nullable: false),
                    tipoUsuario = table.Column<int>(type: "integer", nullable: false),
                    loginRedeSocial = table.Column<int>(type: "integer", nullable: false),
                    idLoginRedeSocial = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    fotoLoginRedeSocial = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    codigo = table.Column<string>(type: "character varying(6)", maxLength: 6, nullable: true),
                    senha = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: true),
                    CreationDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    ChangeDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Status = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Usuario", x => x.Id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Usuario");
        }
    }
}
