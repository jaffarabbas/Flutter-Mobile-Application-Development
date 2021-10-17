// ignore_for_file: file_names, non_constant_identifier_names

class DataSource {
  static Map<dynamic, dynamic> Datamap() {
    return {
      "friendsList": {
        0: {
          "firendId": 1,
          "image": "https://avatars.githubusercontent.com/u/54433038?v=4",
          "username": "Jaffar",
        },
        1: {
          "firendId": 2,
          "image": "https://avatars.githubusercontent.com/u/54433038?v=4",
          "username": "Ahmed",
        }
      },
      "chatList": {
        1: {
          "mainUser": {
            "firendId": 1,
            "image": "",
            "username": "gfg",
          },
          "chatUser": {
            "firendId": 2,
            "image": "",
            "username": "",
          },
          "messsges": {
            "mainUser+messageid": {
              "message": "",
              "timestamps": "",
            },
            "chatUser+messageid": {
              "message": "",
              "timestamps": "",
            }
          }
        }
      }
    };
  }
}
