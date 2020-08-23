class PhotosData {
  int _totalResults;
  int _page;
  int _perPage;
  List<Photos> _photos;
  String _nextPage;

  PhotosData(
      {int totalResults,
      int page,
      int perPage,
      List<Photos> photos,
      String nextPage}) {
    this._totalResults = totalResults;
    this._page = page;
    this._perPage = perPage;
    this._photos = photos;
    this._nextPage = nextPage;
  }

  int get totalResults => _totalResults;
  set totalResults(int totalResults) => _totalResults = totalResults;
  int get page => _page;
  set page(int page) => _page = page;
  int get perPage => _perPage;
  set perPage(int perPage) => _perPage = perPage;
  List<Photos> get photos => _photos;
  set photos(List<Photos> photos) => _photos = photos;
  String get nextPage => _nextPage;
  set nextPage(String nextPage) => _nextPage = nextPage;

  PhotosData.fromJson(Map<String, dynamic> json) {
    _totalResults = json['total_results'];
    _page = json['page'];
    _perPage = json['per_page'];
    if (json['photos'] != null) {
      _photos = new List<Photos>();
      json['photos'].forEach((v) {
        _photos.add(new Photos.fromJson(v));
      });
    }
    _nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_results'] = this._totalResults;
    data['page'] = this._page;
    data['per_page'] = this._perPage;
    if (this._photos != null) {
      data['photos'] = this._photos.map((v) => v.toJson()).toList();
    }
    data['next_page'] = this._nextPage;
    return data;
  }
}

class Photos {
  int _id;
  int _width;
  int _height;
  String _url;
  String _photographer;
  String _photographerUrl;
  int _photographerId;
  Src _src;
  bool _liked;

  Photos(
      {int id,
      int width,
      int height,
      String url,
      String photographer,
      String photographerUrl,
      int photographerId,
      Src src,
      bool liked}) {
    this._id = id;
    this._width = width;
    this._height = height;
    this._url = url;
    this._photographer = photographer;
    this._photographerUrl = photographerUrl;
    this._photographerId = photographerId;
    this._src = src;
    this._liked = liked;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get width => _width;
  set width(int width) => _width = width;
  int get height => _height;
  set height(int height) => _height = height;
  String get url => _url;
  set url(String url) => _url = url;
  String get photographer => _photographer;
  set photographer(String photographer) => _photographer = photographer;
  String get photographerUrl => _photographerUrl;
  set photographerUrl(String photographerUrl) =>
      _photographerUrl = photographerUrl;
  int get photographerId => _photographerId;
  set photographerId(int photographerId) => _photographerId = photographerId;
  Src get src => _src;
  set src(Src src) => _src = src;
  bool get liked => _liked;
  set liked(bool liked) => _liked = liked;

  Photos.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _width = json['width'];
    _height = json['height'];
    _url = json['url'];
    _photographer = json['photographer'];
    _photographerUrl = json['photographer_url'];
    _photographerId = json['photographer_id'];
    _src = json['src'] != null ? new Src.fromJson(json['src']) : null;
    _liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['width'] = this._width;
    data['height'] = this._height;
    data['url'] = this._url;
    data['photographer'] = this._photographer;
    data['photographer_url'] = this._photographerUrl;
    data['photographer_id'] = this._photographerId;
    if (this._src != null) {
      data['src'] = this._src.toJson();
    }
    data['liked'] = this._liked;
    return data;
  }
}

class Src {
  String _original;
  String _large2x;
  String _large;
  String _medium;
  String _small;
  String _portrait;
  String _landscape;
  String _tiny;

  Src(
      {String original,
      String large2x,
      String large,
      String medium,
      String small,
      String portrait,
      String landscape,
      String tiny}) {
    this._original = original;
    this._large2x = large2x;
    this._large = large;
    this._medium = medium;
    this._small = small;
    this._portrait = portrait;
    this._landscape = landscape;
    this._tiny = tiny;
  }

  String get original => _original;
  set original(String original) => _original = original;
  String get large2x => _large2x;
  set large2x(String large2x) => _large2x = large2x;
  String get large => _large;
  set large(String large) => _large = large;
  String get medium => _medium;
  set medium(String medium) => _medium = medium;
  String get small => _small;
  set small(String small) => _small = small;
  String get portrait => _portrait;
  set portrait(String portrait) => _portrait = portrait;
  String get landscape => _landscape;
  set landscape(String landscape) => _landscape = landscape;
  String get tiny => _tiny;
  set tiny(String tiny) => _tiny = tiny;

  Src.fromJson(Map<String, dynamic> json) {
    _original = json['original'];
    _large2x = json['large2x'];
    _large = json['large'];
    _medium = json['medium'];
    _small = json['small'];
    _portrait = json['portrait'];
    _landscape = json['landscape'];
    _tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['original'] = this._original;
    data['large2x'] = this._large2x;
    data['large'] = this._large;
    data['medium'] = this._medium;
    data['small'] = this._small;
    data['portrait'] = this._portrait;
    data['landscape'] = this._landscape;
    data['tiny'] = this._tiny;
    return data;
  }
}
