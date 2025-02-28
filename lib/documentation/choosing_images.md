## Selecting Multiple Images

```dart
import 'package:image_picker/image_picker.dart';
class ImagePicker extends StatefulWidget {
    ImagePicker({super.key});
    @override
    _ImagePickerState createState() => _ImagePickerState();
}
class _ImagePickerState extends State<ImagePicker> {
    List<File> _images = [];

    Future<void> _pickImages () async{
        final XFile? _pickedFiles = await _picker.pickMultiImages();

        if (_pickedFiles != null) {
            for (int i = 0; i < _pickedFiles.length; i++) {
                _images.add(File(_pickedFiles[i]));
            }
        }
    }
}
```


## Selecting Single Image

```dart
import 'package:image_picker/image_picker.dart';
class ImagePicker extends StatefulWidget {
    ImagePicker({super.key});
    @override
    _ImagePickerState createState() => _ImagePickerState();
}
class _ImagePickerState extends State<ImagePicker> {
    File? _image;

    Future<void> _pickImages () async{
        final XFile? _pickedFile = await _picker.pickImages(
            source: ImageSource.gallery
        );

        if (_pickedFile != null) {
            _iamge = File(_pickedFile);
        }
    }
}
```