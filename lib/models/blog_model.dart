class BlogModel {
  String? typeOf;
  int? id;
  String? title;
  String? description;
  String? readablePublishDate;
  String? slug;
  String? path;
  String? url;
  int? commentsCount;
  int? publicReactionsCount;
  int? collectionId;
  String? publishedTimestamp;
  String? language;
  int? subforemId;
  int? positiveReactionsCount;
  String? coverImage;
  String? socialImage;
  String? canonicalUrl;
  String? createdAt;
  String? editedAt;
  String? crosspostedAt;
  String? publishedAt;
  String? lastCommentAt;
  int? readingTimeMinutes;
  List<String>? tagList;
  String? tags;
  User? user;
  FlareTag? flareTag;

  BlogModel(
      {this.typeOf,
        this.id,
        this.title,
        this.description,
        this.readablePublishDate,
        this.slug,
        this.path,
        this.url,
        this.commentsCount,
        this.publicReactionsCount,
        this.collectionId,
        this.publishedTimestamp,
        this.language,
        this.subforemId,
        this.positiveReactionsCount,
        this.coverImage,
        this.socialImage,
        this.canonicalUrl,
        this.createdAt,
        this.editedAt,
        this.crosspostedAt,
        this.publishedAt,
        this.lastCommentAt,
        this.readingTimeMinutes,
        this.tagList,
        this.tags,
        this.user,
        this.flareTag});

  BlogModel.fromJson(Map<String, dynamic> json) {
    typeOf = json['type_of']?.toString();
    id = json['id'];
    title = json['title']?.toString() ?? 'No title';
    description = json['description']?.toString() ?? 'No description';
    readablePublishDate = json['readable_publish_date']?.toString();
    slug = json['slug']?.toString();
    path = json['path']?.toString();
    url = json['url']?.toString();
    commentsCount = json['comments_count'];
    publicReactionsCount = json['public_reactions_count'];
    collectionId = json['collection_id'];
    publishedTimestamp = json['published_timestamp']?.toString();
    language = json['language']?.toString();
    subforemId = json['subforem_id'];
    positiveReactionsCount = json['positive_reactions_count'];

    coverImage = json['cover_image']?.toString();
    socialImage = json['social_image']?.toString();

    canonicalUrl = json['canonical_url']?.toString();
    createdAt = json['created_at']?.toString();
    editedAt = json['edited_at']?.toString();
    crosspostedAt = json['crossposted_at']?.toString();
    publishedAt = json['published_at']?.toString() ?? 'N/A';
    lastCommentAt = json['last_comment_at']?.toString();
    readingTimeMinutes = json['reading_time_minutes'];

    tagList = json['tag_list'] != null ? List<String>.from(json['tag_list']) : [];
    tags = json['tags']?.toString();
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type_of'] = typeOf;
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['readable_publish_date'] = readablePublishDate;
    data['slug'] = slug;
    data['path'] = path;
    data['url'] = url;
    data['comments_count'] = commentsCount;
    data['public_reactions_count'] = publicReactionsCount;
    data['collection_id'] = collectionId;
    data['published_timestamp'] = publishedTimestamp;
    data['language'] = language;
    data['subforem_id'] = subforemId;
    data['positive_reactions_count'] = positiveReactionsCount;
    data['cover_image'] = coverImage;
    data['social_image'] = socialImage;
    data['canonical_url'] = canonicalUrl;
    data['created_at'] = createdAt;
    data['edited_at'] = editedAt;
    data['crossposted_at'] = crosspostedAt;
    data['published_at'] = publishedAt;
    data['last_comment_at'] = lastCommentAt;
    data['reading_time_minutes'] = readingTimeMinutes;
    data['tag_list'] = tagList;
    data['tags'] = tags;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (flareTag != null) {
      data['flare_tag'] = flareTag!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? username;
  String? twitterUsername;
  String? githubUsername;
  int? userId;
  String? websiteUrl;
  String? profileImage;
  String? profileImage90;

  User(
      {this.name,
        this.username,
        this.twitterUsername,
        this.githubUsername,
        this.userId,
        this.websiteUrl,
        this.profileImage,
        this.profileImage90});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    twitterUsername = json['twitter_username'];
    githubUsername = json['github_username'];
    userId = json['user_id'];
    websiteUrl = json['website_url'];
    profileImage = json['profile_image'];
    profileImage90 = json['profile_image_90'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['twitter_username'] = twitterUsername;
    data['github_username'] = githubUsername;
    data['user_id'] = userId;
    data['website_url'] = websiteUrl;
    data['profile_image'] = profileImage;
    data['profile_image_90'] = profileImage90;
    return data;
  }
}

class FlareTag {
  String? name;
  String? bgColorHex;
  String? textColorHex;

  FlareTag({this.name, this.bgColorHex, this.textColorHex});

  FlareTag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bgColorHex = json['bg_color_hex'];
    textColorHex = json['text_color_hex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['bg_color_hex'] = bgColorHex;
    data['text_color_hex'] = textColorHex;
    return data;
  }
}