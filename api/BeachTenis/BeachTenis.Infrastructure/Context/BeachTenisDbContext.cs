using BeachTenis.Core.Entidades;
using BeachTenis.Infrastructure.Configurations;
using Microsoft.EntityFrameworkCore;

namespace BeachTenis.Infrastructure.Context
{
    public class BeachTenisDbContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Arena> Arenas { get; set; }

        public BeachTenisDbContext(DbContextOptions<BeachTenisDbContext> options)
        : base(options)
        {}

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfiguration(new UserConfiguration());
            base.OnModelCreating(modelBuilder);
        }
    }
}
