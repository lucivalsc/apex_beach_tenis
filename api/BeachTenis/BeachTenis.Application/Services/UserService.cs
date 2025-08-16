using BeachTenis.Core.Entidades;
using BeachTenis.Core.Interfaces.Repositories;
using BeachTenis.Core.Interfaces.Services;
using BeachTenis.Core.Models;

namespace BeachTenis.Application.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<IEnumerable<User>> GetAllUsersAsync()
        {
            return await _userRepository.GetAllAsync();
        }

        public async Task<User> GetUserByIdAsync(Guid userId)
        {
            return await _userRepository.GetByIdAsync(userId);
        }

        public async Task<Guid> CreateUserAsync(User user)
        {
            return await _userRepository.CreateAsync(user);
        }

        public async Task UpdateUserAsync(User user)
        {
            user.AlterChangeDate();
            await _userRepository.UpdateAsync(user);
        }

        public async Task DeleteUserAsync(Guid userId)
        {
            await _userRepository.DeleteAsync(userId);
        }

        public async Task<User> GetByEmailPasswordAsync(string email)
        {
            return await _userRepository.GetByEmailPasswordAsync(email);
        }
    }
}
