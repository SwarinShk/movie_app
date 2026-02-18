class Account {
  final Avatar avatar;
  final int id;
  final String iso6391;
  final String iso31661;
  final String name;
  final bool includeAdult;
  final String username;

  Account({
    required this.avatar,
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.includeAdult,
    required this.username,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      avatar: Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      id: json['id'] as int,
      iso6391: json['iso_639_1'] as String,
      iso31661: json['iso_3166_1'] as String,
      name: json['name'] as String? ?? '',
      includeAdult: json['include_adult'] as bool,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'avatar': avatar.toJson(),
    'id': id,
    'iso_639_1': iso6391,
    'iso_3166_1': iso31661,
    'name': name,
    'include_adult': includeAdult,
    'username': username,
  };
}

class Avatar {
  final Gravatar gravatar;
  final Tmdb tmdb;

  Avatar({required this.gravatar, required this.tmdb});

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      gravatar: Gravatar.fromJson(json['gravatar'] as Map<String, dynamic>),
      tmdb: Tmdb.fromJson(json['tmdb'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'gravatar': gravatar.toJson(),
    'tmdb': tmdb.toJson(),
  };
}

class Gravatar {
  final String hash;

  Gravatar({required this.hash});

  factory Gravatar.fromJson(Map<String, dynamic> json) {
    return Gravatar(hash: json['hash'] as String);
  }

  Map<String, dynamic> toJson() => {'hash': hash};
}

class Tmdb {
  final String? avatarPath;

  Tmdb({this.avatarPath});

  factory Tmdb.fromJson(Map<String, dynamic> json) {
    return Tmdb(avatarPath: json['avatar_path'] as String?);
  }

  Map<String, dynamic> toJson() => {'avatar_path': avatarPath};
}
