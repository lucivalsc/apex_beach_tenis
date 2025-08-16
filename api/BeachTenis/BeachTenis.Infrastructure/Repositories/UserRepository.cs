using BeachTenis.Core.Entidades;
using BeachTenis.Core.Interfaces.Repositories;
using BeachTenis.Core.Models;
using BeachTenis.Infrastructure.Context;
using Microsoft.EntityFrameworkCore;

namespace BeachTenis.Infrastructure.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly BeachTenisDbContext _dbContext;

        public UserRepository(BeachTenisDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        async Task<IEnumerable<User>> IUserRepository.GetAllAsync()
        {
            return await _dbContext.Users.ToListAsync();
        }

        public async Task<User> GetByIdAsync(Guid userId)
        {
            return await _dbContext.Users.FindAsync(userId);
        }

        public async Task<Guid> CreateAsync(User user)
        {
            _dbContext.Users.Add(user);
            await _dbContext.SaveChangesAsync();
            return   user.Id;
        }

        public async Task UpdateAsync(User user)
        {
            _dbContext.Entry(user).State = EntityState.Modified;
            await _dbContext.SaveChangesAsync();
        }

        public async Task DeleteAsync(Guid userId)
        {
            var user = await _dbContext.Users.FindAsync(userId);
            _dbContext.Users.Remove(user);
            await _dbContext.SaveChangesAsync();
        }

        public async Task<User> GetByEmailPasswordAsync(string email)
        {
            return await _dbContext.Users.FirstOrDefaultAsync(u => u.Email == email);
        }
    }
}
