const { User, UserModel } = require('./user');
const { Arena, ArenaModel } = require('./arena');
const { Game, GameModel } = require('./game');
const { Training, TrainingModel } = require('./training');
const BaseEntity = require('./baseEntity');
const LoginModel = require('./loginModel');
const LoginSocialModel = require('./loginSocialModel');
const TokenModel = require('./tokenModel');
const JwtConfig = require('./jwtConfig');

module.exports = {
  User,
  UserModel,
  Arena,
  ArenaModel,
  Game,
  GameModel,
  Training,
  TrainingModel,
  BaseEntity,
  LoginModel,
  LoginSocialModel,
  TokenModel,
  JwtConfig
};
