import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/note_database.dart';
import '../models/note.dart';

final _lightColors = [
  Colors.amber.shade200,
  Colors.lightGreen.shade300,
  Colors.deepPurple.shade200,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.purple.shade50,
  Colors.amber.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().add_Hm().format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(color: Colors.grey.shade900),
                ),
                GestureDetector(
                  onTap: ()async {
                     {

                      final notes = note.copy(
                        isImportant: !note.isImportant,
                        number: note.number,
                        title: note.title,
                        description: note.description,
                      );

                      await NotesDatabase.instance.update(notes);
                      await NotesDatabase.instance.readAllNotes();
                    }
                  },
                  child: Icon(
                      note.isImportant == true ? Icons.star : Icons.star_border,
                  color: note.isImportant == true? Colors.red: null),
                ),

              ],
            ),
            const SizedBox(height: 4),
            Text(
              note.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Text(
                note.description,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
