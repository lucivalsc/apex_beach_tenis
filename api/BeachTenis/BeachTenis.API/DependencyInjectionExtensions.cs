using BeachTenis.Core.Interfaces.Repositories;
using BeachTenis.Infrastructure.Context;
using BeachTenis.Infrastructure.Repositories;

namespace BeachTenis.API
{
    public static class DependencyInjectionExtensions
    {
        public static IServiceCollection AddRepositories(this IServiceCollection services)
        {
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<BeachTenisDbContext>();
            return services;
        }
    }
}
