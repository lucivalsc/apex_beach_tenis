using BeachTenis.Core.Enums;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace BeachTenis.Core.Entidades
{
    public abstract class BaseEntity
    {
        public Guid Id { get; private set; }


        [DataType(DataType.Date)]
        public DateTime CreationDate { get; private set; } = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Utc);

        [DataType(DataType.Date)]
        public DateTime ChangeDate { get; private set; } = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Utc);      
        public StatusEnum Status { get; private set; } = Core.Enums.StatusEnum.Ativado;

        public void AlterChangeDate()
        {
            ChangeDate = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Utc);
        }
        public void AlterStatus()
        {
            ChangeDate = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Utc);
            Status = Core.Enums.StatusEnum.Desativado;
        }

    }
}
