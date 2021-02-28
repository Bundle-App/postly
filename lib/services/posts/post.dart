import '../../services/http/index.dart';
import '../../setUp.dart';

class PostService {
  getPost() {
    var _apiClient = locator<ApiClient>();
    return _apiClient.get("/posts");
  }
}
