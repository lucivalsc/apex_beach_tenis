using AutoMapper;
using BeachTenis.Application.DTOs;
using BeachTenis.Core.Entidades;

namespace BeachTenis.API.Mappers
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<User, UserDto>();
        }
    }
}
