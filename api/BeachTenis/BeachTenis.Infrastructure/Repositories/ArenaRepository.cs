using BeachTenis.Core.Entidades;
using BeachTenis.Core.Interfaces.Repositories;
using BeachTenis.Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Infrastructure.Repositories
{
    public class ArenaRepository : IArenaRepository
    {
        private readonly BeachTenisDbContext _dbContext;

        public ArenaRepository(BeachTenisDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        async Task<IEnumerable<Arena>> IArenaRepository.GetAllAsync()
        {
            return await _dbContext.Arenas.ToListAsync();
        }

        public async Task<Arena> GetByIdAsync(Guid ArenaId)
        {
            return await _dbContext.Arenas.FindAsync(ArenaId);
        }

        public async Task<Guid> CreateAsync(Arena Arena)
        {
            _dbContext.Arenas.Add(Arena);
            await _dbContext.SaveChangesAsync();
            return Arena.Id;
        }

        public async Task UpdateAsync(Arena Arena)
        {
            _dbContext.Entry(Arena).State = EntityState.Modified;
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid ArenaId)
        {
            var Arena = await _dbContext.Arenas.FindAsync(ArenaId);
            _dbContext.Arenas.Remove(Arena);
            await _dbContext.SaveChangesAsync();
        }

        public async Task<Arena> GetByEmailAsync(string email)
        {
            return await _dbContext.Arenas.FirstOrDefaultAsync(u => u.Email == email);
        }
    
    }
}
