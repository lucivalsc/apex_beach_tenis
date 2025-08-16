# Guia para criar novas rotas

## Passo 1: Criar a rota

1. Crie uma nova rota no arquivo `lib\app\layers\data\datasources\remote\remote_data_datasource.dart` com o nome pré definidos.
2. Atualize a nova rota no arquivo `lib\app\layers\data\datasources\remote\remote_data_datasource_implementation.dart` com o nome da rota anterior, siga o padrão da rota `datas`, porem apenas métodos POST, e utilize a url `String.fromEnvironment('DEFINE_API_ADDRESS')` do DartDefine).
3. Atualize a nova rota no arquivo `lib\app\layers\domain\repositories\data_repository.dart` com o nome da rota anterior, siga o padrão da rota `datas`.
4. Atualize a nova rota no arquivo `lib\app\layers\data\repositories\data_repository_implementation.dart` com o nome da rota anterior, siga o padrão da rota `datas`.
5. Crie um novo arquivo na pasta `lib\app\layers\domain\usecases\` com o nome da rota anterior, siga o padrão da rota `datas_usecase.dart`.
6. Crie uma nova função no padrão da função `datasResponse` no arquivo `lib\app\layers\presenter\providers\data_provider.dart` com o nome da rota anterior.
7. Atualize a nova usecase no arquivo `lib\app\providers_injections.dart`, adicione a nova usecase no arquivo em `dependentServices` na parte de DATA PROVIDER, e em `consumableProviders` na parte de DATA PROVIDER adicione `context.read()`.
