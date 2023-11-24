import 'dart:io';

import 'package:app_store/main.dart';
import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';
import 'package:xml/xml.dart';

class InstalledController extends ChangeNotifier {
  final _basePath = "/var/lib/flatpak/app";
  final _basePathImage =
      "current/active/files/share/app-info/icons/flatpak/64x64";

  Future<List<ApplicationsModel>> flatpakInstalled() async {
    try {
      List<ApplicationsModel> list = [];
      final appsData = await _getApplicationsFlatpak();

      for (int i = 0; i < appsData.length; i++) {
        final flatpakId = await _getAppDataXml('id');
        final name = await _getAppDataXml('name');
        final summary = await _getAppDataXml('summary');
        final iconDesktopUrl =
            "$_basePath/${appsData[i]}/$_basePathImage/${appsData[i]}.png";

        final applicationModel = ApplicationsModel(
          flatpakAppId: flatpakId[i],
          name: name[i],
          summary: summary[i],
          iconDesktopUrl: iconDesktopUrl,
        );

        list.add(applicationModel);
      }
      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> _getApplicationsFlatpak() async {
    try {
      List<String> list = [];
      final path = _basePath;
      final data = await shell.run("ls $path");

      for (var elements in data.outLines) {
        list.add(elements);
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> _getAppDataXml(String tag) async {
    try {
      List<String> list = [];
      final flatpak = await _getApplicationsFlatpak();

      for (var elements in flatpak) {
        final file = File(
            "$_basePath/$elements/current/active/files/share/appdata/$elements.appdata.xml");
        final document = XmlDocument.parse(file.readAsStringSync());

        final data = document
            .findAllElements(tag)
            .map((element) => element.innerText)
            .first;

        list.add(data);
      }

      return list;
    } catch (e) {
      rethrow;
    }
  }
}
