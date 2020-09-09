import 'package:prevent/models/pessoa_model.dart';
import 'package:prevent/models/user.dart';

class MensagemModel {
  final User pessoa;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  MensagemModel({
    this.pessoa,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}


// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Manuel',
  imageUrl: 'assets/manuel.png',
);

// USERS
final User greg = User(
  id: 1,
  name: 'Manuel',
  imageUrl: 'assets/manuel.png',
);
final User james = User(
  id: 2,
  name: 'Glauber',
  imageUrl: 'assets/manuel.png',
);
final User john = User(
  id: 3,
  name: 'Bruno',
  imageUrl: 'assets/manuel.png',
);
final User olivia = User(
  id: 4,
  name: 'Hnerique',
  imageUrl: 'assets/manuel.png',
);
final User sam = User(
  id: 5,
  name: 'Asriel',
  imageUrl: 'assets/manuel.png',
);
final User sophia = User(
  id: 6,
  name: 'Pablo',
  imageUrl: 'assets/manuel.png',
);


// EXAMPLE CHATS ON HOME SCREEN
List<MensagemModel> chats = [
  MensagemModel(
    pessoa: james,
    time: '5:30 PM',
    text: 'Olá, tudo bem com você?',
    isLiked: false,
    unread: true,
  ),
  MensagemModel(
    pessoa: olivia,
    time: '4:30 PM',
    text: 'Olá, tudo bem com você?',
    isLiked: false,
    unread: true,
  ),
  MensagemModel(
    pessoa: john,
    time: '3:30 PM',
    text: 'Olá, tudo bem com você?',
    isLiked: false,
    unread: false,
  ),
  MensagemModel(
    pessoa: sophia,
    time: '2:30 PM',
    text: 'Olá, tudo bem com você?',
    isLiked: false,
    unread: true,
  ),

  MensagemModel(
    pessoa: sam,
    time: '12:30 PM',
    text: 'Olá, tudo bem com você?',
    isLiked: false,
    unread: false,
  ),
  MensagemModel(
    pessoa: greg,
    time: '11:30 AM',
    text: 'Olá, tudo bem com você?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MensagemModelS IN CHAT SCREEN
List<MensagemModel> MensagemModels = [
  MensagemModel(
    pessoa: james,
    time: '5:30 PM',
    text: 'Olá, tudo bem com você?',
    isLiked: true,
    unread: true,
  ),
  MensagemModel(
    pessoa: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  MensagemModel(
    pessoa: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  MensagemModel(
    pessoa: james,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  MensagemModel(
    pessoa: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  MensagemModel(
    pessoa: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
