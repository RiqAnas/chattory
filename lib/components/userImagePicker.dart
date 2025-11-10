import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Userimagepicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  Userimagepicker({required this.onImagePick});

  @override
  State<Userimagepicker> createState() => _UserimagepickerState();
}

class _UserimagepickerState extends State<Userimagepicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          label: Text("Adicionar Imagem"),
          icon: Icon(Icons.image),
        ),
      ],
    );
  }
}
