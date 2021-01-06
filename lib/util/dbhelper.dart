import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  final int version = 1;
  Database db;

  Future<Database> openDB() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'shopping.db'),
          onCreate: (database, version) {
        database.execute(
            'CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
        database.execute(
            'CREATE TABLE items(id INTEGER PRIMARY KEY), idList INTEGER, name TEXT, quantity TEXT, note TEXT ' +
                'FOREIGN KEY(idList) PREFERENCES lists(id)');
      }, version: version);
    }
    return db;
  }

  Future testDb() async {
    db = await openDB();
    await db.execute('INSERT INTO lists VALUES (0, "Fruits", 2)');
    await db.execute(
        'INSERT INTO items VALUES (0, 0, "Apples", "2 kg", "Better if they are grenn")');
    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');
    print(lists[0].toString());
    print(items[0].toString());
  }
}
