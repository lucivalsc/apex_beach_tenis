using Microsoft.AspNetCore.Http;

namespace BeachTenis.Infrastructure.Middleware
{
    public class CustomUnauthorizedMiddleware
    {
        private readonly RequestDelegate _next;

        public CustomUnauthorizedMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            await _next(context);

            if (context.Response.StatusCode == 401)
            {
                await HandleUnauthorizedAsync(context);
            }
        }

        private static async Task HandleUnauthorizedAsync(HttpContext context)
        {
            context.Response.ContentType = "application/json";
            context.Response.StatusCode = 401;

            await context.Response.WriteAsync("Unauthorized: Sem autorização para acessar recurso");
        }
    }
}
