import 'dart:io';

import 'package:app_cham_cong_option_2/data/service/web_api/api_response.dart';

abstract class ImageRepository {
  Future<List<String>> uploadFiles(List<File> _images);
  Future<String> uploadFile(File _image);
  Future<ApiResponse> uploadMultiImagePost(List<File> _imageFileList);
}
