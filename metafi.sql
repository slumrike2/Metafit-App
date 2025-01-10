CREATE TABLE users(
    id TEXT PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    full_name TEXT NOT NULL,
    birth_date DATE NOT NULL,
    email TEXT NOT NULL,
    gender TEXT NOT NULL,
    height FLOAT NOT NULL,
    weight FLOAT NOT NULL, 
    experience TEXT NOT NULL,
    goal TEXT NOT NULL,
    location TEXT NOT NULL
);



ALTER TABLE users
ADD CONSTRAINT experience_check CHECK (experience IN ('beginner', 'intermediate', 'advanced'));

ALTER TABLE users
ADD CONSTRAINT goal_check CHECK (goal IN ('lose_weight', 'gain_muscle', 'stay_fit'));

ALTER TABLE users
ADD CONSTRAINT location_check CHECK (location IN ('home', 'gym'));

ALTER TABLE users
ADD CONSTRAINT gender_check CHECK (gender IN ('male', 'female', 'other'));

CREATE TABLE muscles(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE muscle_groups(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE muscle_group_muscles(
    id SERIAL PRIMARY KEY,
    muscle_id INT REFERENCES muscles(id),
    muscle_group_id INT REFERENCES muscle_groups(id)
);

CREATE TABLE equipment(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT NOT NULL
);

ALTER TABLE equipment
ADD CONSTRAINT equipment_type CHECK (type IN ('home', 'gym'));

CREATE TABLE exercises(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    difficulty TEXT NOT NULL,
    type TEXT NOT NULL
);

ALTER TABLE exercises
ADD CONSTRAINT difficulty_check CHECK (difficulty IN ('beginner', 'intermediate', 'advanced'));

ALTER TABLE exercises
ADD CONSTRAINT type_check CHECK (type IN ('strength', 'cardio', 'stretching'));

CREATE TABLE exercise_muscle_groups(
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id),
    muscle_group_id INT REFERENCES muscle_groups(id)
);

CREATE TABLE exercise_equipment(
    id SERIAL PRIMARY KEY,
    exercise_id INT REFERENCES exercises(id),
    equipment_id INT REFERENCES equipment(id)
);
CREATE TABLE workouts(
    id SERIAL PRIMARY KEY,
    user_id TEXT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    recomendation FLOAT NOT NULL,
    difficulty TEXT NOT NULL,
    equipment TEXT NOT NULL
);

ALTER TABLE workouts
ADD CONSTRAINT difficulty_check CHECK (difficulty IN ('beginner', 'intermediate', 'advanced'));

ALTER TABLE workouts
ADD CONSTRAINT equipment_check CHECK (equipment IN ('yes', 'no'));

CREATE TABLE workout_exercises(
    id SERIAL PRIMARY KEY,
    workout_id INT REFERENCES workouts(id),
    exercise_id INT REFERENCES exercises(id),
    sets INT NOT NULL,
    reps INT NOT NULL,
    weight FLOAT,
    duration INT,
    distance FLOAT,
    sequence INT NOT NULL,
    UNIQUE (workout_id, sequence)
);

ALTER TABLE workout_exercises
ADD CONSTRAINT sets_check CHECK (sets > 0);

ALTER TABLE workout_exercises
ADD CONSTRAINT reps_check CHECK (reps > 0);

ALTER TABLE workout_exercises
ADD CONSTRAINT weight_check CHECK (weight >= 0);

ALTER TABLE workout_exercises
ADD CONSTRAINT duration_check CHECK (duration >= 0);

ALTER TABLE workout_exercises
ADD CONSTRAINT distance_check CHECK (distance >= 0);

ALTER TABLE workout_exercises
ADD CONSTRAINT sequence_check CHECK (sequence > 0);

CREATE TABLE workout_rating(
    id SERIAL PRIMARY KEY,
    workout_id INT REFERENCES workouts(id),
    difficulty_rating INT NOT NULL,
    routine_rating INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (workout_id, created_at)
);

ALTER TABLE workout_rating
ADD CONSTRAINT check_difficulty_rating CHECK (difficulty_rating >= 1 AND difficulty_rating <= 5);

ALTER TABLE workout_rating
ADD CONSTRAINT check_routine_rating CHECK (routine_rating >= 1 AND routine_rating <= 5);

CREATE TABLE workout_exercise_rating(
    id SERIAL PRIMARY KEY,
    workout_exercise_id INT REFERENCES workout_exercises(id),
    exercise_rating INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (workout_exercise_id, created_at)
);

ALTER TABLE workout_exercise_rating
ADD CONSTRAINT check_exercise_rating CHECK (exercise_rating >= 1 AND exercise_rating <= 5);