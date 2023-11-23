class ApplicationsModel {
  String? flatpakAppId;
  String? name;
  String? summary;
  String? description;
  String? downloadFlatpakRefUrl;
  String? projectLicense;
  String? iconDesktopUrl;
  String? iconMobileUrl;
  String? homepageUrl;
  String? helpUrl;
  String? translateUrl;
  String? bugtrackerUrl;
  String? donationUrl;
  String? developerName;
  List<dynamic>? categories;
  String? currentReleaseDescription;
  String? currentReleaseVersion;
  String? currentReleaseDate;
  String? inStoreSinceDate;
  List<dynamic>? screenshots;

  ApplicationsModel({
    this.flatpakAppId,
    this.name,
    this.summary,
    this.description,
    this.downloadFlatpakRefUrl,
    this.projectLicense,
    this.iconDesktopUrl,
    this.iconMobileUrl,
    this.helpUrl,
    this.translateUrl,
    this.homepageUrl,
    this.bugtrackerUrl,
    this.donationUrl,
    this.developerName,
    this.categories,
    this.currentReleaseDescription,
    this.currentReleaseDate,
    this.currentReleaseVersion,
    this.inStoreSinceDate,
    this.screenshots,
  });

  factory ApplicationsModel.fromJson(Map<String, dynamic> json) {
    return ApplicationsModel(
      flatpakAppId: json['flatpakAppId'],
      name: json['name'],
      summary: json['summary'],
      description: json['description'],
      downloadFlatpakRefUrl: json['downloadFlatpakRefUrl'],
      projectLicense: json['projectLicense'],
      iconDesktopUrl: json['iconDesktopUrl'],
      iconMobileUrl: json['iconMobileUrl'],
      homepageUrl: json['homepageUrl'],
      helpUrl: json['helpUrl'],
      translateUrl: json['translateUrl'],
      bugtrackerUrl: json['bugtrackerUrl'],
      donationUrl: json['donationUrl'],
      developerName: json['developerName'],
      categories: json['categories'],
      currentReleaseDescription: json['currentReleaseDescription'],
      currentReleaseVersion: json['currentReleaseVersion'],
      currentReleaseDate: json['currentReleaseDate'],
      inStoreSinceDate: json['inStoreSinceDate'],
      screenshots: json['screenshots'],
    );
  }
}
