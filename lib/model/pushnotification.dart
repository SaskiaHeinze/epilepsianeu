class PushNotification {
 PushNotification({
    
    this.title,
    this.body,
  });

  String title;
  String body;


  factory PushNotification.fromJson(Map<String, dynamic> data) {
    return PushNotification(
      title: data['title'],
      body: data['body']
    );
  }
}