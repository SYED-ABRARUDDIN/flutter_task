class DataListModel{


  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  String? name;
 

  DataListModel(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.name
      });

  factory DataListModel.fromJSON(Map map) {
    return DataListModel(
      author: map['author'] != null ? map['author'] : "",
      title: map['title'] != null ? map['title'] : "",
      description: map['description'] != null ? map['description'] : "",
      url: map['url'] != null ? map['url'] : "",
      urlToImage: map['urlToImage'] != null ? map['urlToImage'] : "",
      publishedAt: map['publishedAt'] != null ? map['publishedAt'] : "",
      content: map['content'] != null ? map['content'] : "",
      name: map['source'] != null&&map['source']['name']!=null ? map['source']['name'] : "",

        );
  }
}
