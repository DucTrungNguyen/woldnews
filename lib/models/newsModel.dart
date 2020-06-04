

class NewsModel{
  String status;
  int totalResult;
  List<Articles> articles;

  NewsModel({this.status, this.articles, this.totalResult});



  NewsModel.fromJson(Map<dynamic, dynamic> json){
    status = json['status'];
    totalResult = json['totalResult'];
    if (json['articles'] != null){
      articles = new List<Articles>();
      json['articles'].forEach((ar) {
        articles.add(new Articles.fromJson(ar));
      });
    }

    Map<String, dynamic> toJson(){
      final Map<String,dynamic> data = new Map<dynamic, dynamic>();
      data['status'] = this.status;
      data['totalResult'] = this.totalResult;
      if ( this.articles != null){
        data['articles'] = this.articles.map((ar) => ar.toJson()).toList();
      }
    }
  }

//  List<Articles> ar
}

class Articles {
  Source  source;
  String author;
  String title;
  String description;
  String url;
  String urlImage;
  String publishedAt;
  String content;

  Articles({
    this.source,
    this.author,
    this.content,
    this.description,
    this.publishedAt,
    this.title,
    this.url,
    this.urlImage
});


  Articles.fromJson(Map json ){
   source = json['source'] != null ? Source.fromJson(json['source']) : null;
   author = json['author'];
   content = json['content'];
   description = json['description'];
   publishedAt = json['publishedAt'];
   title = json['title'];
   url = json['url'];
   urlImage = json['urlImage'];

  }

  Map<String, dynamic> toJson(){
    final  Map<String, dynamic> data = Map();
    if (this.source != null) {
      data['source'] = this.source.toJson();
    }
    data['author'] = this.author;
    data['title']= this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['urlImage'] = this.urlImage;
    data['publishedAt'] = this.publishedAt;
    data['content'] = this.content;
    return data;
  }


}

class Source {
  String id;
  String name;
  Source({this.id, this.name});

  Source.fromJson(Map<dynamic, dynamic> json){
    id = json['id'];
    name = json['name'];
  }


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}