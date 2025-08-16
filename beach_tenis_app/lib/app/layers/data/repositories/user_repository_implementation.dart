import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource.dart';
import 'package:beach_tenis_app/app/layers/domain/entities/user_entity.dart';
import 'package:beach_tenis_app/app/layers/domain/repositories/user_repository.dart';

class UserRepositoryImplementation implements IUserRepository {
  final IRemoteDataDatasource remoteDataSource;

  UserRepositoryImplementation(this.remoteDataSource);

  @override
  Future<UserEntity?> getUserById(String id) async {
    try {
      final response = await remoteDataSource.getUsers();
      if (response['success'] == true) {
        final users = response['data'] as List;
        final userData = users.where(
          (user) => user['id'] == id,
        );

        if (userData.isNotEmpty) {
          return UserEntity.fromJson(userData.first);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar usuário: $e');
    }
  }

  @override
  Future<UserEntity?> getUserByEmail(String email) async {
    try {
      final response = await remoteDataSource.getUsers();
      if (response['success'] == true) {
        final users = response['data'] as List;
        final userData = users.firstWhere(
          (user) => user['email'] == email,
          orElse: () => <String, dynamic>{},
        );

        if (userData.isNotEmpty) {
          return UserEntity.fromJson(userData);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao buscar usuário por email: $e');
    }
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    try {
      final response = await remoteDataSource.getUsers();
      if (response['success'] == true) {
        final users = response['data'] as List;
        return users.map((userData) => UserEntity.fromJson(userData)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Erro ao buscar usuários: $e');
    }
  }

  @override
  Future<UserEntity> createUser(UserEntity user) async {
    try {
      // Em uma implementação real, isso faria uma chamada POST para criar o usuário
      // Por enquanto, retornamos o usuário com um ID gerado
      final userWithId = UserEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: user.name,
        email: user.email,
        phone: user.phone,
        birthDate: user.birthDate,
        gender: user.gender,
        userType: user.userType,
        profileImageUrl: user.profileImageUrl,
        isVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      return userWithId;
    } catch (e) {
      throw Exception('Erro ao criar usuário: $e');
    }
  }

  @override
  Future<UserEntity> updateUser(UserEntity user) async {
    try {
      // Em uma implementação real, isso faria uma chamada PUT para atualizar o usuário
      final updatedUser = UserEntity(
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        birthDate: user.birthDate,
        gender: user.gender,
        userType: user.userType,
        profileImageUrl: user.profileImageUrl,
        isVerified: user.isVerified,
        createdAt: user.createdAt,
        updatedAt: DateTime.now(),
      );

      return updatedUser;
    } catch (e) {
      throw Exception('Erro ao atualizar usuário: $e');
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      // Em uma implementação real, isso faria uma chamada DELETE
      // Por enquanto, apenas simulamos o sucesso
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (e) {
      throw Exception('Erro ao deletar usuário: $e');
    }
  }

  @override
  Future<bool> verifyUser(String id) async {
    try {
      // Em uma implementação real, isso faria uma chamada para verificar o usuário
      await Future.delayed(const Duration(milliseconds: 300));
      return true;
    } catch (e) {
      throw Exception('Erro ao verificar usuário: $e');
    }
  }
}
