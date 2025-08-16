using AutoMapper;
using BeachTenis.API.Mappers;
using BeachTenis.Application.Services;
using BeachTenis.Core.Interfaces.Repositories;
using BeachTenis.Core.Interfaces.Services;
using BeachTenis.Core.Models;
using BeachTenis.Infrastructure.Context;
using BeachTenis.Infrastructure.Middleware;
using BeachTenis.Infrastructure.Repositories;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Reflection;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin();
        policy.AllowAnyHeader();
        policy.AllowAnyMethod();
    });
});


builder.Services.AddControllers();

var jwtConfig = builder.Configuration.GetSection("JwtConfig").Get<JwtConfig>();
builder.Services.Configure<JwtConfig>(builder.Configuration.GetSection("JwtConfig"));

builder.Services.AddDbContext<BeachTenisDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetValue<string>("ConnectionStrings:DefaultConnection")));

builder.Services.AddAutoMapper(typeof(MappingProfile));

builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IArenaRepository, ArenaRepository>();
builder.Services.AddScoped<IArenaService, ArenaService>();
builder.Services.AddTransient<IAuthService, AuthService>();

var key = Encoding.ASCII.GetBytes("Beachj6m83Y&0ZvWD[}S/}EnU+d8|£rRL*0Tenis");
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.SaveToken = true;
    options.RequireHttpsMetadata = false;
    options.TokenValidationParameters = new TokenValidationParameters()
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ClockSkew = TimeSpan.Zero,

        ValidAudience = builder.Configuration["JWT:ValidAudience"],
        ValidIssuer = builder.Configuration["JWT:ValidIssuer"],
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["JWT:SecretKey"]))
    };
});

builder.Services.AddControllers().AddJsonOptions(options =>
{
    options.JsonSerializerOptions.PropertyNamingPolicy = null;
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo
    {
        Title = "Beach Tenis",
        Version = "v1",
        Description = "API de acesso ao Projeto Beach Tenis",
        Contact = new Microsoft.OpenApi.Models.OpenApiContact
        {
            Name = "Beach Tenis",
            Email = "mrsilvatads@gmail.com",
            Url = new Uri("https://teste.com.br")
        }
    });
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    c.IncludeXmlComments(xmlPath);

    //c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme()
    //{
    //    Name = "Authorization",
    //    Type = SecuritySchemeType.ApiKey,
    //    Scheme = "Bearer",
    //    BearerFormat = "JWT",
    //    In = ParameterLocation.Header,
    //    Description = "JWT Authorization header using the Bearer scheme.\r\n\r\n Enter 'Bearer'[space] and then your token in the text input below.\r\n\r\nExample: \"Bearer 12345abcdef\"",
    //});
    //c.AddSecurityRequirement(new OpenApiSecurityRequirement
    //            {
    //                {
    //                      new OpenApiSecurityScheme
    //                      {
    //                          Reference = new OpenApiReference
    //                          {
    //                              Type = ReferenceType.SecurityScheme,
    //                              Id = "Bearer"
    //                          }
    //                      },
    //                     new string[] {}
    //                }
    //            });
});


var app = builder.Build();

if (app.Environment.IsDevelopment() || app.Environment.IsProduction())
{
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "Beach Tenis API V1");
    });
}

app.UseHttpsRedirection();

app.UseCors();
app.UseAuthentication();
app.UseAuthorization();

app.UseMiddleware<CustomUnauthorizedMiddleware>();


app.MapControllers();

app.Run();
