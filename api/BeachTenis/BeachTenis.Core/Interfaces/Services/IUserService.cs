using BeachTenis.Core.Entidades;
using BeachTenis.Core.Models;

namespace BeachTenis.Core.Interfaces.Services
{
    public interface IUserService
    {
        public Task<IEnumerable<User>> GetAllUsersAsync();
        public Task<User> GetUserByIdAsync(Guid userId);
        public Task<Guid> CreateUserAsync(User user);
        public Task UpdateUserAsync(User user);
        public Task DeleteUserAsync(Guid userId);
        public Task<User> GetByEmailPasswordAsync(string email);
    }
}
