import 'package:apex_sports/app/layers/domain/entities/user_entity.dart';

abstract class IUserRepository {
  Future<UserEntity?> getUserById(String id);
  Future<UserEntity?> getUserByEmail(String email);
  Future<List<UserEntity>> getAllUsers();
  Future<UserEntity> createUser(UserEntity user);
  Future<UserEntity> updateUser(UserEntity user);
  Future<void> deleteUser(String id);
  Future<bool> verifyUser(String id);
}
