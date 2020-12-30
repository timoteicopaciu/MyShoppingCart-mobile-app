// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorShoppingCartDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ShoppingCartDatabaseBuilder databaseBuilder(String name) =>
      _$ShoppingCartDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ShoppingCartDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ShoppingCartDatabaseBuilder(null);
}

class _$ShoppingCartDatabaseBuilder {
  _$ShoppingCartDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$ShoppingCartDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ShoppingCartDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ShoppingCartDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$ShoppingCartDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ShoppingCartDatabase extends ShoppingCartDatabase {
  _$ShoppingCartDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ItemDao _itemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `items` (`id` INTEGER, `name` TEXT, `quantity` TEXT, `shop` TEXT, `details` TEXT, `status` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ItemDao get itemDao {
    return _itemDaoInstance ??= _$ItemDao(database, changeListener);
  }
}

class _$ItemDao extends ItemDao {
  _$ItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _itemInsertionAdapter = InsertionAdapter(
            database,
            'items',
            (Item item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'quantity': item.quantity,
                  'shop': item.shop,
                  'details': item.details,
                  'status': item.status
                }),
        _itemUpdateAdapter = UpdateAdapter(
            database,
            'items',
            ['id'],
            (Item item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'quantity': item.quantity,
                  'shop': item.shop,
                  'details': item.details,
                  'status': item.status
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Item> _itemInsertionAdapter;

  final UpdateAdapter<Item> _itemUpdateAdapter;

  @override
  Future<List<Item>> findAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM items',
        mapper: (Map<String, dynamic> row) => Item(
            id: row['id'] as int,
            name: row['name'] as String,
            quantity: row['quantity'] as String,
            shop: row['shop'] as String,
            details: row['details'] as String,
            status: row['status'] as String));
  }

  @override
  Future<List<Item>> findItemById(int id) async {
    return _queryAdapter.queryList('SELECT * FROM items WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => Item(
            id: row['id'] as int,
            name: row['name'] as String,
            quantity: row['quantity'] as String,
            shop: row['shop'] as String,
            details: row['details'] as String,
            status: row['status'] as String));
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM items WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<int> insertItem(Item item) {
    return _itemInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateItem(Item item) async {
    await _itemUpdateAdapter.update(item, OnConflictStrategy.abort);
  }
}
