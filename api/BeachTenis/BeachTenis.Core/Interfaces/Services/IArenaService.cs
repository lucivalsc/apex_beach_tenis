using BeachTenis.Core.Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeachTenis.Core.Interfaces.Services
{
    public interface IArenaService
    {
        public Task<IEnumerable<Arena>> GetAllArenassAsync();
        public Task<Arena> GetArenaByIdAsync(Guid arenaId);
        public Task<Guid> CreateArenaAsync(Arena arena);
        public Task UpdateArenaAsync(Arena arena);
        public Task DeleteArenaAsync(Guid arenaId);
        public Task<Arena> GetByEmailAsync(string email);
    }
}
