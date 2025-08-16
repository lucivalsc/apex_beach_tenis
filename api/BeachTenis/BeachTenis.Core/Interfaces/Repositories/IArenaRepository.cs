using BeachTenis.Core.Entidades;

namespace BeachTenis.Core.Interfaces.Repositories
{
    public interface IArenaRepository
    {
        Task<IEnumerable<Arena>> GetAllAsync();

        Task<Arena> GetByIdAsync(Guid arenaId);
        Task<Guid> CreateAsync(Arena arena);
        Task UpdateAsync(Arena arena);
        Task DeleteAsync(Guid arenaIdId);
        Task<Arena> GetByEmailAsync(string email);
    }
}
