import 'dart:async';
import 'dart:convert';

import 'package:beach_tenis_app/app/common/http/http_client.dart';
import 'package:beach_tenis_app/app/common/models/exception_models.dart';
import 'package:beach_tenis_app/app/layers/data/datasources/remote/remote_data_datasource.dart';

class RemoteDataDatasourceImplementation implements IRemoteDataDatasource {
  final Map<String, String> headers = {"Content-Type": "application/json"};
  final IHttpClient client;

  RemoteDataDatasourceImplementation(this.client);

  @override
  Future<List<Object>> datas(List<Object> objects) async {
    // final user = objects[0] as String;
    // final password = objects[1] as String;
    final dataini = objects[2] as String;
    final datafin = objects[3] as String;
    final branch = jsonDecode(objects[4] as String);
    final rota = objects[5] as String;
    const token =
        'eyJpdiI6ImVXYU5SR0RzekZUS0p1SGgwUTArK2c9PSIsInZhbHVlIjoiNWVvOEY4SThDcklEbDlOMTJ3b05Gckh6SHlmeXpLUzN3VDhEajNvU2owNzBlVWcvTFBhYlJud3FPUkdJSk9HYWJ5cWRhTTNaSlhwZlRyRjZiSWQxenJIcGFxWkR1MkVCQjQ3QnpIalVObVV6c0VyQ3pxSVBVak5vT2NhYU9KbHgiLCJtYWMiOiI5ZTZkNzhkYTc0OTYyNjJlMjY5NTRjYTFlYWIyNzkyMjk1ZjE3NjcwZTI5ZDQwMzNlYTQyNTdiMzkyNjU4ZDlkIiwidGFnIjoiIn0';
    final resource = objects[6] as String;

    Map<String, dynamic> payLoad = {};

    payLoad = {
      "guid": branch['guid'],
      "startDate": dataini,
      "endDate": datafin,
      "user": branch['uciduser'],
    };

    try {
      final response = await client.post(
        url: '$resource/$rota',
        headers: Map.from(headers)
          ..addAll(
            {
              'api_token': token,
            },
          ),
        payload: payLoad,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return [response.data];
      } else {
        throw ServerException(
          statusCode: response.statusCode,
          message: response.data["message"],
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Object>> getSyncDatas(List<Object> objects) async {
    return [];
  }

  // Implementações mockadas específicas do Fertilink
  @override
  Future<Map<String, dynamic>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simula latência
    return {
      "success": true,
      "data": [
        {
          "id": "user_001",
          "name": "Maria Silva",
          "email": "maria@fertilink.com",
          "phone": "+5511999999999",
          "birthDate": "1990-05-15T00:00:00.000Z",
          "gender": "feminino",
          "userType": "demandante",
          "profileImageUrl": "https://example.com/profile1.jpg",
          "isVerified": true,
          "createdAt": "2024-01-15T10:30:00.000Z",
          "updatedAt": "2024-07-18T12:00:00.000Z"
        },
        {
          "id": "user_002",
          "name": "João Santos",
          "email": "joao@fertilink.com",
          "phone": "+5511888888888",
          "birthDate": "1985-08-22T00:00:00.000Z",
          "gender": "masculino",
          "userType": "doador",
          "profileImageUrl": "https://example.com/profile2.jpg",
          "isVerified": true,
          "createdAt": "2024-02-10T14:20:00.000Z",
          "updatedAt": "2024-07-18T11:45:00.000Z"
        },
        {
          "id": "user_003",
          "name": "Ana Costa",
          "email": "ana@fertilink.com",
          "phone": "+5511777777777",
          "birthDate": "1992-12-03T00:00:00.000Z",
          "gender": "feminino",
          "userType": "demandante",
          "profileImageUrl": "https://example.com/profile3.jpg",
          "isVerified": false,
          "createdAt": "2024-03-05T09:15:00.000Z",
          "updatedAt": "2024-07-18T10:30:00.000Z"
        }
      ]
    };
  }

  @override
  Future<Map<String, dynamic>> getDonors() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return {
      "success": true,
      "data": [
        {
          "id": "donor_001",
          "userId": "user_002",
          "name": "João Santos",
          "firstName": "João",
          "lastName": "Santos",
          "age": 32,
          "ethnicity": "Latino",
          "height": 1.78,
          "weight": 75.5,
          "bloodType": "O+",
          "education": "Ensino Superior Completo",
          "profession": "Engenheiro de Software",
          "eyeColor": "Castanho",
          "hairColor": "Preto",
          "skinColor": "Moreno",
          "hobbies": ["Leitura", "Natação", "Violão", "Culinária"],
          "motivationLetter":
              "Acredito que ajudar famílias a realizarem o sonho de ter filhos é uma das coisas mais nobres que podemos fazer. Tenho saúde excelente e gostaria de contribuir para que mais pessoas possam experimentar a alegria da paternidade/maternidade.",
          "medicalExams": [
            "Hemograma completo - Normal",
            "Espermograma - Excelente",
            "Teste de DSTs - Negativo",
            "Exame cardiológico - Normal"
          ],
          "medicalHistory": "Sem histórico de doenças hereditárias",
          "isAvailable": true,
          "totalDonations": 3,
          "rating": 4.8,
          "isVerified": true,
          "lastMedicalCheckup": "2024-06-15T00:00:00.000Z"
        },
        {
          "id": "donor_002",
          "userId": "user_004",
          "name": "Carlos Oliveira",
          "firstName": "Carlos",
          "lastName": "Oliveira",
          "age": 35,
          "ethnicity": "Caucasiano",
          "height": 1.82,
          "weight": 80.0,
          "bloodType": "A+",
          "education": "Pós-graduação",
          "profession": "Médico",
          "eyeColor": "Azul",
          "hairColor": "Loiro",
          "skinColor": "Branco",
          "hobbies": ["Corrida", "Xadrez", "Fotografia"],
          "motivationLetter":
              "Como médico, entendo profundamente a importância da fertilidade na vida das pessoas. Quero usar minha saúde e genética para ajudar casais que enfrentam dificuldades para conceber.",
          "medicalExams": [
            "Hemograma completo - Normal",
            "Espermograma - Ótimo",
            "Teste de DSTs - Negativo",
            "Exame neurológico - Normal"
          ],
          "medicalHistory": "Histórico familiar saudável",
          "isAvailable": true,
          "totalDonations": 5,
          "rating": 4.9,
          "isVerified": true,
          "lastMedicalCheckup": "2024-07-01T00:00:00.000Z"
        },
        {
          "id": "donor_003",
          "userId": "user_005",
          "name": "Rafael Mendes",
          "firstName": "Rafael",
          "lastName": "Mendes",
          "age": 29,
          "ethnicity": "Pardo",
          "height": 1.75,
          "weight": 72.0,
          "bloodType": "B+",
          "education": "Mestrado",
          "profession": "Professor",
          "eyeColor": "Verde",
          "hairColor": "Castanho",
          "skinColor": "Pardo",
          "hobbies": ["Música", "Viagens", "Escrita"],
          "motivationLetter":
              "Sempre acreditei na importância de ajudar o próximo. Como professor, sei o quanto é importante contribuir para o futuro das pessoas.",
          "medicalExams": ["Hemograma completo - Normal", "Espermograma - Bom", "Teste de DSTs - Negativo"],
          "medicalHistory": "Sem histórico de doenças crônicas",
          "isAvailable": true,
          "totalDonations": 2,
          "rating": 4.7,
          "isVerified": true,
          "lastMedicalCheckup": "2024-05-20T00:00:00.000Z"
        }
      ]
    };
  }

  @override
  Future<Map<String, dynamic>> getDemandantes() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return {
      "success": true,
      "data": [
        {
          "userId": "user_001",
          "relationshipStatus": "Casada",
          "partnerName": "Carlos Silva",
          "reasonForDonation": "Infertilidade masculina diagnosticada após 3 anos de tentativas",
          "preferredAgeMin": 25,
          "preferredAgeMax": 35,
          "preferredEducation": "Ensino Superior",
          "preferredBloodType": "O+",
          "preferredEyeColor": "Castanho",
          "preferredHairColor": null,
          "preferredSkinColor": null,
          "importantCharacteristics": [
            "Saúde física excelente",
            "Estabilidade emocional",
            "Histórico familiar saudável"
          ],
          "additionalNotes":
              "Procuramos alguém que entenda a importância deste momento em nossas vidas e que seja comprometido com o processo.",
          "isActivelySearching": true,
          "lastActivity": "2024-07-18T11:30:00.000Z"
        },
        {
          "userId": "user_003",
          "relationshipStatus": "União Estável",
          "partnerName": "Pedro Costa",
          "reasonForDonation": "Baixa contagem de espermatozoides",
          "preferredAgeMin": 28,
          "preferredAgeMax": 40,
          "preferredEducation": null,
          "preferredBloodType": null,
          "preferredEyeColor": null,
          "preferredHairColor": null,
          "preferredSkinColor": null,
          "importantCharacteristics": ["Responsabilidade", "Empatia", "Comprometimento"],
          "additionalNotes": "Valorizamos muito a transparência e a comunicação aberta durante todo o processo.",
          "isActivelySearching": true,
          "lastActivity": "2024-07-18T09:45:00.000Z"
        }
      ]
    };
  }

  @override
  Future<Map<String, dynamic>> getMatches(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "success": true,
      "data": [
        {
          "id": "match_001",
          "demandanteId": "user_001",
          "donorId": "user_002",
          "status": "accepted",
          "createdAt": "2024-07-15T14:20:00.000Z",
          "acceptedAt": "2024-07-16T10:30:00.000Z",
          "completedAt": null,
          "compatibilityScore": 0.92,
          "notes": "Excelente compatibilidade em todos os aspectos",
          "isActive": true
        },
        {
          "id": "match_002",
          "demandanteId": "user_003",
          "donorId": "user_004",
          "status": "pending",
          "createdAt": "2024-07-18T09:15:00.000Z",
          "acceptedAt": null,
          "completedAt": null,
          "compatibilityScore": 0.87,
          "notes": null,
          "isActive": true
        }
      ]
    };
  }

  @override
  Future<Map<String, dynamic>> getChatMessages(String matchId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {
      "success": true,
      "data": [
        {
          "id": "msg_001",
          "matchId": matchId,
          "senderId": "user_001",
          "receiverId": "user_002",
          "content": "Olá! Muito prazer em conhecê-lo. Estamos muito animados com esta oportunidade.",
          "messageType": "text",
          "sentAt": "2024-07-16T11:00:00.000Z",
          "readAt": "2024-07-16T11:05:00.000Z",
          "isEncrypted": true,
          "attachmentUrl": null,
          "attachmentType": null
        },
        {
          "id": "msg_002",
          "matchId": matchId,
          "senderId": "user_002",
          "receiverId": "user_001",
          "content":
              "Olá Maria! O prazer é meu. Também estou muito feliz com este match. Quando podemos conversar mais sobre o processo?",
          "messageType": "text",
          "sentAt": "2024-07-16T11:10:00.000Z",
          "readAt": "2024-07-16T11:12:00.000Z",
          "isEncrypted": true,
          "attachmentUrl": null,
          "attachmentType": null
        },
        {
          "id": "msg_003",
          "matchId": matchId,
          "senderId": "user_001",
          "receiverId": "user_002",
          "content":
              "Que tal agendarmos uma videochamada para esta semana? Podemos conversar sobre expectativas e próximos passos.",
          "messageType": "text",
          "sentAt": "2024-07-16T11:15:00.000Z",
          "readAt": null,
          "isEncrypted": true,
          "attachmentUrl": null,
          "attachmentType": null
        }
      ]
    };
  }

  @override
  Future<Map<String, dynamic>> searchDonors(Map<String, dynamic> filters) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Simula busca com filtros
    return {
      "success": true,
      "data": [
        {
          "userId": "user_002",
          "height": 1.78,
          "weight": 75.5,
          "bloodType": "O+",
          "education": "Ensino Superior Completo",
          "profession": "Engenheiro de Software",
          "eyeColor": "Castanho",
          "hairColor": "Preto",
          "skinColor": "Moreno",
          "hobbies": ["Leitura", "Natação", "Violão", "Culinária"],
          "motivationLetter":
              "Acredito que ajudar famílias a realizarem o sonho de ter filhos é uma das coisas mais nobres que podemos fazer.",
          "medicalExams": ["Hemograma completo - Normal", "Espermograma - Excelente", "Teste de DSTs - Negativo"],
          "isAvailable": true,
          "totalDonations": 3,
          "rating": 4.8,
          "lastMedicalCheckup": "2024-06-15T00:00:00.000Z"
        }
      ],
      "filters_applied": filters
    };
  }

  @override
  Future<Map<String, dynamic>> createMatch(Map<String, dynamic> matchData) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return {
      "success": true,
      "data": {
        "id": "match_${DateTime.now().millisecondsSinceEpoch}",
        "demandanteId": matchData['demandanteId'],
        "donorId": matchData['donorId'],
        "status": "pending",
        "createdAt": DateTime.now().toIso8601String(),
        "acceptedAt": null,
        "completedAt": null,
        "compatibilityScore": 0.85,
        "notes": null,
        "isActive": true
      }
    };
  }

  @override
  Future<Map<String, dynamic>> sendMessage(Map<String, dynamic> messageData) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return {
      "success": true,
      "data": {
        "id": "msg_${DateTime.now().millisecondsSinceEpoch}",
        "matchId": messageData["matchId"],
        "senderId": messageData["senderId"],
        "content": messageData["content"],
        "timestamp": DateTime.now().toIso8601String(),
        "isRead": false
      }
    };
  }

  // Implementações dos métodos de Demandante
  @override
  Future<Map<String, dynamic>?> getDemandanteProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final demandantes = await getDemandantes();
    final list = (demandantes['data'] as List<dynamic>);
    try {
      final demandante = list.firstWhere(
        (d) => d['userId'] == userId,
      );
      return demandante as Map<String, dynamic>;
    } catch (e) {
      // Retorna null se não encontrar o demandante
      return null;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllDemandantes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final demandantes = await getDemandantes();
    final list = (demandantes['data'] as List<dynamic>);
    return List<Map<String, dynamic>>.from(list);
  }

  @override
  Future<List<Map<String, dynamic>>> getActivelySearchingDemandantes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final demandantes = await getDemandantes();
    final list = (demandantes['data'] as List<dynamic>);
    final activelySearching = list.where((d) => d['isActivelySearching'] == true).toList();
    return List<Map<String, dynamic>>.from(activelySearching);
  }

  @override
  Future<Map<String, dynamic>> createDemandanteProfile(Map<String, dynamic> profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Simulação de criação com geração de ID
    return {
      ...profile,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<Map<String, dynamic>> updateDemandanteProfile(Map<String, dynamic> profile) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return {
      ...profile,
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  @override
  Future<void> deleteDemandanteProfile(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Em um cenário real, aqui seria feita a exclusão do perfil
    return;
  }

  @override
  Future<void> updateDemandanteSearchStatus(String userId, bool isActivelySearching) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // Em um cenário real, aqui seria atualizado o status de busca do demandante
    return;
  }
}
