class SearchImages {
  int? total;
  int? totalPages;
  List<Results>? results;

  SearchImages({this.total, this.totalPages, this.results});

  SearchImages.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? id;
  String? slug;
  AlternativeSlugs? alternativeSlugs;
  String? createdAt;
  String? updatedAt;
  String? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  List<dynamic>? breadcrumbs;
  Urls? urls;
  Links? links;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic? sponsorship;
  TopicSubmissions? topicSubmissions;
  String? assetType;
  User? user;

  Results(
      {this.id,
      this.slug,
      this.alternativeSlugs,
      this.createdAt,
      this.updatedAt,
      this.promotedAt,
      this.width,
      this.height,
      this.color,
      this.blurHash,
      this.description,
      this.altDescription,
      this.breadcrumbs,
      this.urls,
      this.links,
      this.likes,
      this.likedByUser,
      this.currentUserCollections,
      this.sponsorship,
      this.topicSubmissions,
      this.assetType,
      this.user});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    alternativeSlugs = json['alternative_slugs'] != null
        ? new AlternativeSlugs.fromJson(json['alternative_slugs'])
        : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promotedAt = json['promoted_at'];
    width = json['width'];
    height = json['height'];
    color = json['color'];
    blurHash = json['blur_hash'];
    description = json['description'];
    altDescription = json['alt_description'];
    if (json['breadcrumbs'] != null) {
      breadcrumbs = json['breadcrumbs'];
      // json['breadcrumbs'].forEach((v) {
      //   breadcrumbs!.add(new Null.fromJson(v));
      // });
    }
    urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    likes = json['likes'];
    likedByUser = json['liked_by_user'];
    if (json['current_user_collections'] != null) {
      currentUserCollections = json['current_user_collections'];
      // json['current_user_collections'].forEach((v) {
      //   currentUserCollections!.add(new Null.fromJson(v));
      // });
    }
    sponsorship = json['sponsorship'];
    topicSubmissions = json['topic_submissions'] != null
        ? new TopicSubmissions.fromJson(json['topic_submissions'])
        : null;
    assetType = json['asset_type'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    if (this.alternativeSlugs != null) {
      data['alternative_slugs'] = this.alternativeSlugs!.toJson();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['promoted_at'] = this.promotedAt;
    data['width'] = this.width;
    data['height'] = this.height;
    data['color'] = this.color;
    data['blur_hash'] = this.blurHash;
    data['description'] = this.description;
    data['alt_description'] = this.altDescription;
      data['breadcrumbs'] = this.breadcrumbs;
    // if (this.breadcrumbs != null) {
    //   data['breadcrumbs'] = this.breadcrumbs!.map((v) => v.toJson()).toList();
    // }
    if (this.urls != null) {
      data['urls'] = this.urls!.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    data['likes'] = this.likes;
    data['liked_by_user'] = this.likedByUser;
      data['current_user_collections'] = this.currentUserCollections;
    // if (this.currentUserCollections != null) {
    //   data['current_user_collections'] =
    //       this.currentUserCollections!.map((v) => v.toJson()).toList();
    // }
    data['sponsorship'] = this.sponsorship;
    if (this.topicSubmissions != null) {
      data['topic_submissions'] = this.topicSubmissions!.toJson();
    }
    data['asset_type'] = this.assetType;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class AlternativeSlugs {
  String? en;
  String? es;
  String? ja;
  String? fr;
  String? it;
  String? ko;
  String? de;
  String? pt;

  AlternativeSlugs(
      {this.en, this.es, this.ja, this.fr, this.it, this.ko, this.de, this.pt});

  AlternativeSlugs.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    es = json['es'];
    ja = json['ja'];
    fr = json['fr'];
    it = json['it'];
    ko = json['ko'];
    de = json['de'];
    pt = json['pt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['es'] = this.es;
    data['ja'] = this.ja;
    data['fr'] = this.fr;
    data['it'] = this.it;
    data['ko'] = this.ko;
    data['de'] = this.de;
    data['pt'] = this.pt;
    return data;
  }
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls(
      {this.raw,
      this.full,
      this.regular,
      this.small,
      this.thumb,
      this.smallS3});

  Urls.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    full = json['full'];
    regular = json['regular'];
    small = json['small'];
    thumb = json['thumb'];
    smallS3 = json['small_s3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    data['small_s3'] = this.smallS3;
    return data;
  }
}

class Links {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  Links({this.self, this.html, this.download, this.downloadLocation});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    download = json['download'];
    downloadLocation = json['download_location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['download'] = this.download;
    data['download_location'] = this.downloadLocation;
    return data;
  }
}

class TopicSubmissions {
  CurrentEvents? currentEvents;
  FoodDrink? foodDrink;

  TopicSubmissions({this.currentEvents, this.foodDrink});

  TopicSubmissions.fromJson(Map<String, dynamic> json) {
    currentEvents = json['current-events'] != null
        ? new CurrentEvents.fromJson(json['current-events'])
        : null;
    foodDrink = json['food-drink'] != null
        ? new FoodDrink.fromJson(json['food-drink'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentEvents != null) {
      data['current-events'] = this.currentEvents!.toJson();
    }
    if (this.foodDrink != null) {
      data['food-drink'] = this.foodDrink!.toJson();
    }
    return data;
  }
}

class CurrentEvents {
  String? status;

  CurrentEvents({this.status});

  CurrentEvents.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}

class FoodDrink {
  String? status;
  String? approvedOn;

  FoodDrink({this.status, this.approvedOn});

  FoodDrink.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    approvedOn = json['approved_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['approved_on'] = this.approvedOn;
    return data;
  }
}

class User {
  String? id;
  String? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  LinksA? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  int? totalPromotedPhotos;
  int? totalIllustrations;
  int? totalPromotedIllustrations;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  User(
      {this.id,
      this.updatedAt,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.portfolioUrl,
      this.bio,
      this.location,
      this.links,
      this.profileImage,
      this.instagramUsername,
      this.totalCollections,
      this.totalLikes,
      this.totalPhotos,
      this.totalPromotedPhotos,
      this.totalIllustrations,
      this.totalPromotedIllustrations,
      this.acceptedTos,
      this.forHire,
      this.social});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    updatedAt = json['updated_at'];
    username = json['username'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    twitterUsername = json['twitter_username'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    links = json['links'] != null ? new LinksA.fromJson(json['links']) : null;
    profileImage = json['profile_image'] != null
        ? new ProfileImage.fromJson(json['profile_image'])
        : null;
    instagramUsername = json['instagram_username'];
    totalCollections = json['total_collections'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    totalPromotedPhotos = json['total_promoted_photos'];
    totalIllustrations = json['total_illustrations'];
    totalPromotedIllustrations = json['total_promoted_illustrations'];
    acceptedTos = json['accepted_tos'];
    forHire = json['for_hire'];
    social =
        json['social'] != null ? new Social.fromJson(json['social']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['username'] = this.username;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['twitter_username'] = this.twitterUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['bio'] = this.bio;
    data['location'] = this.location;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage!.toJson();
    }
    data['instagram_username'] = this.instagramUsername;
    data['total_collections'] = this.totalCollections;
    data['total_likes'] = this.totalLikes;
    data['total_photos'] = this.totalPhotos;
    data['total_promoted_photos'] = this.totalPromotedPhotos;
    data['total_illustrations'] = this.totalIllustrations;
    data['total_promoted_illustrations'] = this.totalPromotedIllustrations;
    data['accepted_tos'] = this.acceptedTos;
    data['for_hire'] = this.forHire;
    if (this.social != null) {
      data['social'] = this.social!.toJson();
    }
    return data;
  }
}

class LinksA {
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  LinksA(
      {this.self,
      this.html,
      this.photos,
      this.likes,
      this.portfolio,
      this.following,
      this.followers});

  LinksA.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    html = json['html'];
    photos = json['photos'];
    likes = json['likes'];
    portfolio = json['portfolio'];
    following = json['following'];
    followers = json['followers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['photos'] = this.photos;
    data['likes'] = this.likes;
    data['portfolio'] = this.portfolio;
    data['following'] = this.following;
    data['followers'] = this.followers;
    return data;
  }
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class Social {
  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  Null? paypalEmail;

  Social(
      {this.instagramUsername,
      this.portfolioUrl,
      this.twitterUsername,
      this.paypalEmail});

  Social.fromJson(Map<String, dynamic> json) {
    instagramUsername = json['instagram_username'];
    portfolioUrl = json['portfolio_url'];
    twitterUsername = json['twitter_username'];
    paypalEmail = json['paypal_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instagram_username'] = this.instagramUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['twitter_username'] = this.twitterUsername;
    data['paypal_email'] = this.paypalEmail;
    return data;
  }
}
