class ApplicationsModel {
  String? flatpakAppId;
  String? name;
  String? summary;
  String? iconDesktopUrl;
  String? iconMobileUrl;
  String? currentReleaseVersion;
  String? currentReleaseDate;
  String? inStoreSinceDate;

  ApplicationsModel({
    this.flatpakAppId,
    this.name,
    this.summary,
    this.iconDesktopUrl,
    this.iconMobileUrl,
    this.currentReleaseDate,
    this.currentReleaseVersion,
    this.inStoreSinceDate,
  });

  factory ApplicationsModel.fromJson(Map<String, dynamic> json) {
    return ApplicationsModel(
      flatpakAppId: json['flatpakAppId'],
      name: json['name'],
      summary: json['summary'],
      iconDesktopUrl: json['iconDesktopUrl'],
      iconMobileUrl: json['iconMobileUrl'],
      currentReleaseVersion: json['currentReleaseVersion'],
      currentReleaseDate: json['currentReleaseDate'],
      inStoreSinceDate: json['inStoreSinceDate'],
    );
  }
}
