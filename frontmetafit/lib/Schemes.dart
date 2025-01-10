class Equipment {
  int id;
  String name;
  String type;

  Equipment({required this.id, required this.name, required this.type});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class ExerciseEquipment {
  int? equipmentId;
  int? exerciseId;
  int id;

  ExerciseEquipment({this.equipmentId, this.exerciseId, required this.id});

  factory ExerciseEquipment.fromJson(Map<String, dynamic> json) {
    return ExerciseEquipment(
      equipmentId: json['equipment_id'],
      exerciseId: json['exercise_id'],
      id: json['id'],
    );
  }
}

class ExerciseMuscleGroups {
  int? exerciseId;
  int id;
  int? muscleGroupId;

  ExerciseMuscleGroups({this.exerciseId, required this.id, this.muscleGroupId});

  factory ExerciseMuscleGroups.fromJson(Map<String, dynamic> json) {
    return ExerciseMuscleGroups(
      exerciseId: json['exercise_id'],
      id: json['id'],
      muscleGroupId: json['muscle_group_id'],
    );
  }
}

class Exercises {
  String description;
  String difficulty;
  int id;
  String name;
  String type;

  Exercises(
      {required this.description,
      required this.difficulty,
      required this.id,
      required this.name,
      required this.type});

  factory Exercises.fromJson(Map<String, dynamic> json) {
    return Exercises(
      description: json['description'],
      difficulty: json['difficulty'],
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }
}

class MuscleGroupMuscles {
  int id;
  int? muscleGroupId;
  int? muscleId;

  MuscleGroupMuscles({required this.id, this.muscleGroupId, this.muscleId});

  factory MuscleGroupMuscles.fromJson(Map<String, dynamic> json) {
    return MuscleGroupMuscles(
      id: json['id'],
      muscleGroupId: json['muscle_group_id'],
      muscleId: json['muscle_id'],
    );
  }
}

class MuscleGroups {
  int id;
  String name;

  MuscleGroups({required this.id, required this.name});

  factory MuscleGroups.fromJson(Map<String, dynamic> json) {
    return MuscleGroups(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Muscles {
  int id;
  String name;

  Muscles({required this.id, required this.name});

  factory Muscles.fromJson(Map<String, dynamic> json) {
    return Muscles(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Users {
  String birthDate;
  String? createdAt;
  String experience;
  String fullName;
  String gender;
  String goal;
  int height;
  int id;
  String location;
  int weight;

  Users({
    required this.birthDate,
    this.createdAt,
    required this.experience,
    required this.fullName,
    required this.gender,
    required this.goal,
    required this.height,
    required this.id,
    required this.location,
    required this.weight,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      birthDate: json['birth_date'],
      createdAt: json['created_at'],
      experience: json['experience'],
      fullName: json['full_name'],
      gender: json['gender'],
      goal: json['goal'],
      height: json['height'],
      id: json['id'],
      location: json['location'],
      weight: json['weight'],
    );
  }
}

class WorkoutExerciseRating {
  String? createdAt;
  int exerciseRating;
  int id;
  int? workoutExerciseId;

  WorkoutExerciseRating(
      {this.createdAt,
      required this.exerciseRating,
      required this.id,
      this.workoutExerciseId});

  factory WorkoutExerciseRating.fromJson(Map<String, dynamic> json) {
    return WorkoutExerciseRating(
      createdAt: json['created_at'],
      exerciseRating: json['exercise_rating'],
      id: json['id'],
      workoutExerciseId: json['workout_exercise_id'],
    );
  }
}

class WorkoutExercises {
  double? distance;
  int? duration;
  int? exerciseId;
  int id;
  int reps;
  int sequence;
  int sets;
  double? weight;
  int? workoutId;

  WorkoutExercises({
    this.distance,
    this.duration,
    this.exerciseId,
    required this.id,
    required this.reps,
    required this.sequence,
    required this.sets,
    this.weight,
    this.workoutId,
  });

  factory WorkoutExercises.fromJson(Map<String, dynamic> json) {
    return WorkoutExercises(
      distance: json['distance'],
      duration: json['duration'],
      exerciseId: json['exercise_id'],
      id: json['id'],
      reps: json['reps'],
      sequence: json['sequence'],
      sets: json['sets'],
      weight: json['weight'],
      workoutId: json['workout_id'],
    );
  }
}

class WorkoutRating {
  String? createdAt;
  int difficultyRating;
  int id;
  int routineRating;
  int? workoutId;

  WorkoutRating(
      {this.createdAt,
      required this.difficultyRating,
      required this.id,
      required this.routineRating,
      this.workoutId});

  factory WorkoutRating.fromJson(Map<String, dynamic> json) {
    return WorkoutRating(
      createdAt: json['created_at'],
      difficultyRating: json['difficulty_rating'],
      id: json['id'],
      routineRating: json['routine_rating'],
      workoutId: json['workout_id'],
    );
  }
}

class Workouts {
  String? createdAt;
  String description;
  String difficulty;
  String equipment;
  int id;
  String name;
  int recomendation;
  int? userId;

  Workouts({
    this.createdAt,
    required this.description,
    required this.difficulty,
    required this.equipment,
    required this.id,
    required this.name,
    required this.recomendation,
    this.userId,
  });

  factory Workouts.fromJson(Map<String, dynamic> json) {
    return Workouts(
      createdAt: json['created_at'],
      description: json['description'],
      difficulty: json['difficulty'],
      equipment: json['equipment'],
      id: json['id'],
      name: json['name'],
      recomendation: json['recomendation'],
      userId: json['user_id'],
    );
  }
}
