# Guia para criar novas telas

## Passo 1: Criar a tela

1. Crie uma nova pasta no diretório `lib/app/layers/presenter/logged_in/screens/` com o nome do módulo.
   1. logged_in para telas após login
   2. not_logged_in para telas antes do login
2. Crie uma pasta para o módulo em questão e dentro dela crie o arquivo `nome_arquivo.dart`.
3. Crie um arquivo `nome_arquivo_provider.dart` para o módulo em questão, que extenda o change notifier, para manter toda a lógica de negócios da tela e reatividade da tela.
4. Adicione o `nome_arquivo_provider.dart` ao arquivo `provider_injections.dart` seguindo o padrão do arquivo, para que possa ser instanciado corretamente.
5. Implemente a tela seguindo o padrão Clean Architecture.
6. Utilize o arquivo `lib\app\common\styles\app_styles.dart` para estilizar a tela em partes que não estejam contempladas no `ThemeData`.
7. Adicione a tela ao arquivo `on_generate_route.dart` seguindo o padrão do arquivo.
8. Adicione no fluxo de navegação de telas a função de navegação seguindo o padrão do arquivo `navigation.dart`, `push(context, tela, arguments)` ou `pushNamed(context, name, arguments)` ou `pushWithoutFading(context, tela)` ou `pushReplacement(context, tela)` ou `pushAndRemoveUntil(context, tela)`.
9. Adicione variáveis de estado para a tela seguindo o padrão do arquivo `login_screen.dart`, adicione os providers necessários, as funções de navegação e os estados de variáveis, os controladores de texto e os controladores de animação, initState e dispose.
10. Implemente a tela seguindo o padrão Clean Architecture.
