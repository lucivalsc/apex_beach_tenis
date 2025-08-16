# Guia de Estrutura Flutter - Clean Architecture

Este documento apresenta uma explicação detalhada da estrutura de pastas para uma aplicação Flutter baseada na arquitetura Clean Architecture, focada na separação de responsabilidades e facilidade de desenvolvimento e manutenção.

## Estrutura de Pastas

```
connect_go_app/
├── app/
│   ├── common/
│   │   ├── assets/
│   │   │   ├── lottie/
│   │   │   ├── png/
│   │   │   ├── svg/
│   │   ├── endpoints/
│   │   ├── export/
│   │   ├── http/
│   │   ├── models/
│   │   ├── styles/
│   │   ├── utils/
│   │   └── widgets/
│   ├── layers/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── local/
│   │   │   │   └── remote/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presenter/
├── functions.dart
├── loading_overlay.dart
├── loading_screen.dart
├── main.dart
├── navigation.dart
├── on_generate_route.dart
├── provider_injections.dart
└── starter.dart
```

## Explicação Detalhada

### app/common

A pasta `common` contém componentes reutilizáveis e utilitários que são usados em diversas partes da aplicação.

#### assets/

Armazena os arquivos de recursos, como imagens, animações e outros arquivos estáticos.

- **lottie/**: Animações em formato Lottie para serem usadas na UI

  ```dart
  Lottie.asset('app/common/assets/lottie/animation.json');
  ```

- **png/**: Imagens em formato PNG

  ```dart
  Image.asset('app/common/assets/png/logo.png');
  ```

- **svg/**: Imagens vetoriais escaláveis

  ```dart
  SvgPicture.asset('app/common/assets/svg/icon.svg');
  ```

#### endpoints/

Contém as URLs e pontos de acesso para APIs ou serviços externos.

```dart
class ApiEndpoints {
  static const String baseUrl = 'https://api.example.com/';
  static const String getUser = '${baseUrl}user';
}
```

#### export/

Destinado ao código que trata exportação de dados ou funcionalidades.

```dart
class DataExport {
  static Future<void> exportData(List<String> data) async {
    // Lógica para exportar dados para CSV ou outro formato
  }
}
```

#### http/

Define a comunicação HTTP, incluindo clientes HTTP e configurações.

```dart
class HttpClient {
  final Dio dio = Dio();

  Future<Response> getData(String url) async {
    return await dio.get(url);
  }
}
```

#### models/

Contém modelos de dados genéricos utilizados em várias partes da aplicação.

```dart
class Failure extends Equatable {
  final String failureType;
  final String? title;
  final String? message;

  const Failure({required this.failureType, this.title, this.message});

  @override
  List<Object?> get props => [failureType, title, message];
}

```

#### styles/

Definições de estilos visuais da aplicação.

```dart
class AppStyles {
  
  // Tema Claro
  final lightBackgroundColor = const Color(0xFFE8F4FD); // Azul muito claro
  // Tema Escuro
  final darkBackgroundColor = const Color(0xFF1E1E1E); // Cinza muito escuro

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
}
```

#### utils/

Funções utilitárias e helpers reutilizáveis.

```dart
class Cryptography {
  static final _key = Key.fromBase16("770a8a65da156d24ee2a093277530142");
  static final _iv = IV.fromBase16("101112131415161718191a1b1c1d1e1f");
  static final _encrypter = Encrypter(AES(_key, mode: AESMode.cbc, padding: "PKCS7"));

  static String encrypt(String input) {
    return _encrypter.encrypt(input, iv: _iv).base64;
  }

  static String decrypt(String input) {
    return _encrypter.decrypt64(input, iv: _iv);
  }
}
```

#### widgets/

Widgets personalizados reutilizáveis.

```dart
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
```

### app/layers

A pasta `layers` organiza a aplicação em camadas seguindo os princípios da Clean Architecture.

#### data/

Contém a implementação concreta de fontes de dados.

- **datasources/**: Define fontes de dados
  - **local/**: Implementações para fontes de dados locais

    ```dart
    class LocalDatasource {
      Future<List<User>> getUsersFromLocalDb() async {
        // Lógica para pegar dados locais
      }
    }
    ```
  
  - **remote/**: Implementações para fontes de dados externas

    ```dart
    class RemoteDatasource {
      final HttpClient client;

      RemoteDatasource({required this.client});

      Future<List<User>> getUsersFromApi() async {
        final response = await client.getData('https://api.example.com/users');
        return (response.data as List).map((e) => User.fromJson(e)).toList();
      }
    }
    ```

- **models/**: Representações dos dados na camada de dados

  ```dart
  class UserModel {
    final String name;
    final String email;

    UserModel({required this.name, required this.email});

    factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
        name: json['name'],
        email: json['email'],
      );
    }
  }
  ```

- **repositories/**: Implementações de repositórios

  ```dart
  class UserRepository {
    final RemoteDatasource remoteDatasource;
    final LocalDatasource localDatasource;

    UserRepository({required this.remoteDatasource, required this.localDatasource});

    Future<List<User>> getUsers() async {
      return await remoteDatasource.getUsersFromApi();
    }
  }
  ```

#### domain/

Representa a camada de domínio com a lógica de negócios.

- **entities/**: Entidades principais do sistema

  ```dart
  class User {
    final String name;
    final String email;

    User({required this.name, required this.email});
  }
  ```

- **repositories/**: Interfaces que definem como os dados são acessados

  ```dart
  abstract class UserRepository {
    Future<List<User>> getUsers();
  }
  ```

- **usecases/**: Casos de uso do sistema

  ```dart
  class DatasUsecase implements Usecase<List<Object>, List<Object>> {
    final IDataRepository repository;

    const DatasUsecase(this.repository);

    @override
    Future<Either<Failure, List<Object>>> call(List<Object> objects) async {
      return await repository.datas(objects);
    }
  }
  ```

#### presenter/

Contém a camada de apresentação responsável pela interação com o usuário.

## Arquivos no Nível Raiz

### main.dart

Ponto de entrada principal da aplicação.

```dart
void main() {
  runApp(MyApp());
}
```

### navigation.dart

Gerencia funções de navegação da aplicação.

```dart
Future pushNamed(BuildContext context, String name, {Object? arguments}) async {
  try {
    return await Navigator.of(context).pushNamed(name, arguments: arguments);
  } catch (e) {
    showFlushbar(context, "Operação Inválida", "A tela desejada não possui implementação.", 3);
  }
}
```

### provider_injections.dart

Configuração de injeção de dependências.

```dart
final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<UserRepository>(UserRepository());
  getIt.registerFactory(() => GetUsersUseCase(repository: getIt()));
}
```

### loading_overlay.dart

Widget para exibir indicador de carregamento.

```dart
class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
```

### Outros arquivos

- **loading_screen.dart**: Tela de carregamento durante inicialização
- **on_generate_route.dart**: Lógica de geração de rotas dinâmicas
- **starter.dart**: Lógica de inicialização da aplicação
- **functions.dart**: Funções utilitárias gerais

## Conclusão

Esta estrutura está muito bem organizada para uma aplicação Flutter utilizando Clean Architecture, com camadas bem definidas para separar responsabilidades entre UI (presentation), lógica de negócios (domain) e fontes de dados (data). A centralização de componentes reutilizáveis na pasta `common` facilita a manutenção e evolução do sistema.

A organização promove:

- **Separação de responsabilidades**
- **Facilidade de manutenção**
- **Testabilidade**
- **Escalabilidade**
- **Reutilização de código**
