// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProductDao? _productDaoInstance;

  UserDao? _userDaoInstance;

  PaymentDao? _paymentDaoInstance;

  ThemeDao? _themeDaoInstance;

  LanguageDao? _languageDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 5,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
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
            'CREATE TABLE IF NOT EXISTS `ProductModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `serialNumber` TEXT NOT NULL, `description` TEXT NOT NULL, `brand` TEXT NOT NULL, `model` TEXT NOT NULL, `color` TEXT NOT NULL, `material` TEXT NOT NULL, `purchaseDate` INTEGER NOT NULL, `originalPrice` REAL NOT NULL, `discountedPrice` REAL NOT NULL, `discountStartDate` INTEGER, `discountEndDate` INTEGER, `currentStock` INTEGER NOT NULL, `reorderPoint` INTEGER NOT NULL, `lastStockUpdate` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `users` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `username` TEXT NOT NULL, `password` TEXT NOT NULL, `role` TEXT NOT NULL, `nickname` TEXT NOT NULL, `isFirstLogin` INTEGER NOT NULL, `loggedin` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `payments` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `totalPrice` REAL NOT NULL, `productDetails` TEXT NOT NULL, `userId` INTEGER NOT NULL, `userNickname` TEXT NOT NULL, `paymentDateTime` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ThemeModel` (`id` INTEGER NOT NULL, `themeType` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LanguageModel` (`id` INTEGER NOT NULL, `code` TEXT NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  PaymentDao get paymentDao {
    return _paymentDaoInstance ??= _$PaymentDao(database, changeListener);
  }

  @override
  ThemeDao get themeDao {
    return _themeDaoInstance ??= _$ThemeDao(database, changeListener);
  }

  @override
  LanguageDao get languageDao {
    return _languageDaoInstance ??= _$LanguageDao(database, changeListener);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _productModelInsertionAdapter = InsertionAdapter(
            database,
            'ProductModel',
            (ProductModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'serialNumber': item.serialNumber,
                  'description': item.description,
                  'brand': item.brand,
                  'model': item.model,
                  'color': item.color,
                  'material': item.material,
                  'purchaseDate': item.purchaseDate,
                  'originalPrice': item.originalPrice,
                  'discountedPrice': item.discountedPrice,
                  'discountStartDate': item.discountStartDate,
                  'discountEndDate': item.discountEndDate,
                  'currentStock': item.currentStock,
                  'reorderPoint': item.reorderPoint,
                  'lastStockUpdate': item.lastStockUpdate
                }),
        _productModelUpdateAdapter = UpdateAdapter(
            database,
            'ProductModel',
            ['id'],
            (ProductModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'serialNumber': item.serialNumber,
                  'description': item.description,
                  'brand': item.brand,
                  'model': item.model,
                  'color': item.color,
                  'material': item.material,
                  'purchaseDate': item.purchaseDate,
                  'originalPrice': item.originalPrice,
                  'discountedPrice': item.discountedPrice,
                  'discountStartDate': item.discountStartDate,
                  'discountEndDate': item.discountEndDate,
                  'currentStock': item.currentStock,
                  'reorderPoint': item.reorderPoint,
                  'lastStockUpdate': item.lastStockUpdate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductModel> _productModelInsertionAdapter;

  final UpdateAdapter<ProductModel> _productModelUpdateAdapter;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM ProductModel',
        mapper: (Map<String, Object?> row) => ProductModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            serialNumber: row['serialNumber'] as String,
            description: row['description'] as String,
            brand: row['brand'] as String,
            model: row['model'] as String,
            color: row['color'] as String,
            material: row['material'] as String,
            purchaseDate: row['purchaseDate'] as int,
            originalPrice: row['originalPrice'] as double,
            discountedPrice: row['discountedPrice'] as double,
            discountStartDate: row['discountStartDate'] as int?,
            discountEndDate: row['discountEndDate'] as int?,
            currentStock: row['currentStock'] as int,
            reorderPoint: row['reorderPoint'] as int,
            lastStockUpdate: row['lastStockUpdate'] as int));
  }

  @override
  Future<ProductModel?> getProductBySerialNumber(String serialNumber) async {
    return _queryAdapter.query(
        'SELECT * FROM ProductModel WHERE serialNumber = ?1',
        mapper: (Map<String, Object?> row) => ProductModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            serialNumber: row['serialNumber'] as String,
            description: row['description'] as String,
            brand: row['brand'] as String,
            model: row['model'] as String,
            color: row['color'] as String,
            material: row['material'] as String,
            purchaseDate: row['purchaseDate'] as int,
            originalPrice: row['originalPrice'] as double,
            discountedPrice: row['discountedPrice'] as double,
            discountStartDate: row['discountStartDate'] as int?,
            discountEndDate: row['discountEndDate'] as int?,
            currentStock: row['currentStock'] as int,
            reorderPoint: row['reorderPoint'] as int,
            lastStockUpdate: row['lastStockUpdate'] as int),
        arguments: [serialNumber]);
  }

  @override
  Future<void> insertProduct(ProductModel product) async {
    await _productModelInsertionAdapter.insert(
        product, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _productModelUpdateAdapter.update(product, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'users',
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'role': item.role,
                  'nickname': item.nickname,
                  'isFirstLogin': item.isFirstLogin ? 1 : 0,
                  'loggedin': item.loggedin ? 1 : 0
                }),
        _userModelUpdateAdapter = UpdateAdapter(
            database,
            'users',
            ['id'],
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'password': item.password,
                  'role': item.role,
                  'nickname': item.nickname,
                  'isFirstLogin': item.isFirstLogin ? 1 : 0,
                  'loggedin': item.loggedin ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final UpdateAdapter<UserModel> _userModelUpdateAdapter;

  @override
  Future<UserModel?> getUserByUsername(String username) async {
    return _queryAdapter.query('SELECT * FROM users WHERE username = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            username: row['username'] as String,
            password: row['password'] as String,
            role: row['role'] as String,
            isFirstLogin: (row['isFirstLogin'] as int) != 0,
            nickname: row['nickname'] as String,
            id: row['id'] as int?,
            loggedin: (row['loggedin'] as int) != 0),
        arguments: [username]);
  }

  @override
  Future<UserModel?> getUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM users WHERE id = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            username: row['username'] as String,
            password: row['password'] as String,
            role: row['role'] as String,
            isFirstLogin: (row['isFirstLogin'] as int) != 0,
            nickname: row['nickname'] as String,
            id: row['id'] as int?,
            loggedin: (row['loggedin'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<bool?> isUserFirstLogin(String username) async {
    return _queryAdapter.query(
        'SELECT isFirstLogin FROM users WHERE username = ?1',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [username]);
  }

  @override
  Future<void> updateLoginStatus(
    int id,
    bool loggedin,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE users SET loggedin = ?2 WHERE id = ?1',
        arguments: [id, loggedin ? 1 : 0]);
  }

  @override
  Future<void> insertUser(UserModel user) async {
    await _userModelInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await _userModelUpdateAdapter.update(user, OnConflictStrategy.abort);
  }
}

class _$PaymentDao extends PaymentDao {
  _$PaymentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _paymentModelInsertionAdapter = InsertionAdapter(
            database,
            'payments',
            (PaymentModel item) => <String, Object?>{
                  'id': item.id,
                  'totalPrice': item.totalPrice,
                  'productDetails': item.productDetails,
                  'userId': item.userId,
                  'userNickname': item.userNickname,
                  'paymentDateTime': item.paymentDateTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PaymentModel> _paymentModelInsertionAdapter;

  @override
  Future<List<PaymentModel>> findPaymentsByUserIdAndNickname(
    int userId,
    String nickname,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM payments WHERE userId = ?1 AND userNickname = ?2',
        mapper: (Map<String, Object?> row) => PaymentModel(
            id: row['id'] as int?,
            totalPrice: row['totalPrice'] as double,
            productDetails: row['productDetails'] as String,
            userId: row['userId'] as int,
            userNickname: row['userNickname'] as String,
            paymentDateTime: row['paymentDateTime'] as int),
        arguments: [userId, nickname]);
  }

  @override
  Future<List<PaymentModel>> findPaymentsByUserId(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM payments WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => PaymentModel(
            id: row['id'] as int?,
            totalPrice: row['totalPrice'] as double,
            productDetails: row['productDetails'] as String,
            userId: row['userId'] as int,
            userNickname: row['userNickname'] as String,
            paymentDateTime: row['paymentDateTime'] as int),
        arguments: [userId]);
  }

  @override
  Future<List<PaymentModel>> findAllPayments() async {
    return _queryAdapter.queryList('SELECT * FROM payments',
        mapper: (Map<String, Object?> row) => PaymentModel(
            id: row['id'] as int?,
            totalPrice: row['totalPrice'] as double,
            productDetails: row['productDetails'] as String,
            userId: row['userId'] as int,
            userNickname: row['userNickname'] as String,
            paymentDateTime: row['paymentDateTime'] as int));
  }

  @override
  Future<void> insertPayment(PaymentModel payment) async {
    await _paymentModelInsertionAdapter.insert(
        payment, OnConflictStrategy.abort);
  }
}

class _$ThemeDao extends ThemeDao {
  _$ThemeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _themeModelInsertionAdapter = InsertionAdapter(
            database,
            'ThemeModel',
            (ThemeModel item) =>
                <String, Object?>{'id': item.id, 'themeType': item.themeType});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ThemeModel> _themeModelInsertionAdapter;

  @override
  Future<ThemeModel?> getTheme() async {
    return _queryAdapter.query('SELECT * FROM ThemeModel WHERE id = 1',
        mapper: (Map<String, Object?> row) => ThemeModel(
            id: row['id'] as int, themeType: row['themeType'] as String));
  }

  @override
  Future<void> saveTheme(ThemeModel theme) async {
    await _themeModelInsertionAdapter.insert(theme, OnConflictStrategy.replace);
  }
}

class _$LanguageDao extends LanguageDao {
  _$LanguageDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _languageModelInsertionAdapter = InsertionAdapter(
            database,
            'LanguageModel',
            (LanguageModel item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name
                }),
        _languageModelUpdateAdapter = UpdateAdapter(
            database,
            'LanguageModel',
            ['id'],
            (LanguageModel item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LanguageModel> _languageModelInsertionAdapter;

  final UpdateAdapter<LanguageModel> _languageModelUpdateAdapter;

  @override
  Future<LanguageModel?> getLanguage() async {
    return _queryAdapter.query('SELECT * FROM LanguageModel LIMIT 1',
        mapper: (Map<String, Object?> row) => LanguageModel(
            id: row['id'] as int,
            code: row['code'] as String,
            name: row['name'] as String));
  }

  @override
  Future<void> deleteAllLanguages() async {
    await _queryAdapter.queryNoReturn('DELETE FROM LanguageModel');
  }

  @override
  Future<void> insertLanguage(LanguageModel language) async {
    await _languageModelInsertionAdapter.insert(
        language, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateLanguage(LanguageModel language) async {
    await _languageModelUpdateAdapter.update(
        language, OnConflictStrategy.replace);
  }
}
