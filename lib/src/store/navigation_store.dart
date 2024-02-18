import 'package:app_store/src/modules/applications/widgets/build_applications.dart';
import 'package:flutter/material.dart';

final currentView = ValueNotifier<Widget>(
    BuildApplicationsWidget(endpoint: "collection/popular"));
