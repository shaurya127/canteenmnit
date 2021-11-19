import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider getImgUrl(String? img, File? imgChosen, bool admin) {
  if (imgChosen != null) return FileImage(imgChosen);
  return img != null
      ? FadeInImage(
          placeholder: Image.asset("assets/images/" +
                  (admin ? "Canteenmnit-logo.jpg" : "profile-img.png"))
              .image,
          image: NetworkImage(img),
        ).image
      : Image.asset("assets/images/" +
              (admin ? "Canteenmnit-logo.jpg" : "profile-img.png"))
          .image;
}
