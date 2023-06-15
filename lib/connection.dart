import 'package:final_bim494_project/models/medicine_usage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:postgres/postgres.dart';

import 'models/gender.dart';

Future<PostgreSQLConnection> getConnection() async {
  await dotenv.load();

  final connection = PostgreSQLConnection(
    dotenv.env['HOST_URL']!,
    int.parse(dotenv.env['PORT']!),
    dotenv.env['DB_NAME']!,
    username: dotenv.env['USERNAME'],
    password: dotenv.env['PASSWORD'],
    useSSL: true,
  );

  try {
    await connection.open();
    print('Connected to PostgreSQL');
  } catch (e) {
    print('Error connecting to PostgreSQL: $e');
    rethrow;
  }

  return connection;
}

Future<void> registerUser(
    String name,
    String email,
    String password,
    Gender gender,
    int age,
    ) async {
  final connection = await getConnection();

  try {
    final query = '''
      INSERT INTO users (name, email, password, gender, age)
      VALUES (@name, @email, @password, @gender, @age)
    ''';

    await connection.query(query, substitutionValues: {
      'name': name,
      'email': email,
      'password': password,
      'gender': gender.toString().split('.').last,
      'age': age,
    });

    print('User registered successfully');
  } catch (e) {
    print('Error while registering user: $e');
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}

Future<void> addMedication(
    String name,
    String description,
    int stock,
    int dosage,
    MedicineUsage usage,
    ) async {
  final connection = await getConnection();

  try {
    final query = '''
      INSERT INTO medications (name, description, stock, dosage, usage)
      VALUES (@name, @description, @stock, @dosage, @usage)
    ''';

    await connection.query(query, substitutionValues: {
      'name': name,
      'description': description,
      'stock': stock,
      'dosage': dosage,
      'usage': usage.toString().split('.').last,
    });

    print('Medication added successfully');
  } catch (e) {
    print('Error while adding medication: $e');
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}

Future<void> addDoctor(
    String name,
    String department,
    String phoneNumber,
    ) async {
  final connection = await getConnection();

  try {
    final query = '''
      INSERT INTO doctors (name, department, phone_number)
      VALUES (@name, @department, @phoneNumber)
    ''';

    await connection.query(query, substitutionValues: {
      'name': name,
      'department': department,
      'phoneNumber': phoneNumber,
    });

    print('Doctor added successfully');
  } catch (e) {
    print('Error while adding doctor: $e');
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}

Future<bool> loginUser(String email, String password) async {
  final connection = await getConnection();

  try {
    final query = '''
      SELECT COUNT(*) as count
      FROM users
      WHERE email = @email
        AND password = @password
    ''';

    final result = await connection.query(query, substitutionValues: {
      'email': email,
      'password': password,
    });

    final count = result[0]['count'] as int;
    if (count > 0) {
      print('User logged in successfully');
      return true;
    } else {
      print('Invalid email or password');
      return false;
    }
  } catch (e) {
    print('Error while logging in: $e');
    return false;
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}

Future<void> deleteUser(String email) async {
  final connection = await getConnection();

  try {
    final query = '''
      DELETE FROM users
      WHERE email = @email
    ''';

    await connection.query(query, substitutionValues: {
      'email': email,
    });

    print('User deleted successfully');
  } catch (e) {
    print('Error while deleting user: $e');
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}

Future<void> deleteMedication(String name) async {
  final connection = await getConnection();

  try {
    final query = '''
      DELETE FROM medications
      WHERE name = @name
    ''';

    await connection.query(query, substitutionValues: {
      'name': name,
    });

    print('Medication deleted successfully');
  } catch (e) {
    print('Error while deleting medication: $e');
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}

Future<void> deleteDoctor(String name) async {
  final connection = await getConnection();

  try {
    final query = '''
      DELETE FROM doctors
      WHERE name = @name
    ''';

    await connection.query(query, substitutionValues: {
      'name': name,
    });

    print('Doctor deleted successfully');
  } catch (e) {
    print('Error while deleting doctor: $e');
  } finally {
    await connection.close();
    print('Disconnected from PostgreSQL');
  }
}