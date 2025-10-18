import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final VoidCallback? onDelete;

  const UserCard({
    super.key,
    required this.user,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: user.avatar != null
              ? NetworkImage(user.avatar!)
              : null,
          child: user.avatar == null
              ? Text(user.name[0].toUpperCase())
              : null,
        ),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}
