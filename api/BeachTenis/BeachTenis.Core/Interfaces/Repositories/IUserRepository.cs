using BeachTenis.Core.Entidades;

namespace BeachTenis.Core.Interfaces.Repositories
{
    public interface IUserRepository
    {
        Task<IEnumerable<User>> GetAllAsync();
        Task<User> GetByIdAsync(Guid userId);
        Task<Guid> CreateAsync(User user);
        Task UpdateAsync(User user);
        Task DeleteAsync(Guid userId);
        Task<User> GetByEmailPasswordAsync(string email);
    }
}
