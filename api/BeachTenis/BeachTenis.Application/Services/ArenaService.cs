using BeachTenis.Core.Entidades;
using BeachTenis.Core.Interfaces.Repositories;
using BeachTenis.Core.Interfaces.Services;

namespace BeachTenis.Application.Services
{
    public class ArenaService : IArenaService
    {
        private readonly IArenaRepository _arenaRepository;

        public ArenaService(IArenaRepository userRepository)
        {
            _arenaRepository = userRepository;
        }

        public async Task<IEnumerable<Arena>> GetAllArenassAsync()
        {
            return await _arenaRepository.GetAllAsync();
        }

        public async Task<Arena> GetArenaByIdAsync(Guid arenaId)
        {
            return await _arenaRepository.GetByIdAsync(arenaId);
        }

        public async Task<Guid> CreateArenaAsync(Arena arena)
        {
            return await _arenaRepository.CreateAsync(arena);
        }

        public async Task UpdateArenaAsync(Arena arena)
        {
            arena.AlterChangeDate();
            await _arenaRepository.UpdateAsync(arena);
        }

        public async Task DeleteArenaAsync(Guid arenaId)
        {
            await _arenaRepository.DeleteAsync(arenaId);
        }

        public async Task<Arena> GetByEmailAsync(string email)
        {
            return await _arenaRepository.GetByEmailAsync(email);
        }
    }
}
