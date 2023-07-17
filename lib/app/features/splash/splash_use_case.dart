import 'package:qapp/app/data/network/base_repository.dart';

class SplashUseCase {
  late BaseRepository _repository;

  SplashUseCase(BaseRepository repository) {
    _repository = repository;
  }

  Future<bool> checkIfUserIsLoggedIn() async {
    return await _repository.isLoggedIn();
  }

  Future<String> getAuthToken() async {
    return await _repository.getAuthToken();
  }
}
