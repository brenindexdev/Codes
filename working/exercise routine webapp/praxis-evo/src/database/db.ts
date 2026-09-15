import Dexie, { type Table } from 'dexie';

export interface UserProfile { 
  id?: number; 
  height: number; 
  initialWeight: number; 
  currentWeight: number; 
  age: number; 
  startDate: string;
  gender?: 'M' | 'F';
  activityLevel?: number; //multiplicador de TDEE (Taxa Metabólica)
  bodyFat?: number;
}

export interface Stage { id?: number; name: string; startDate: string; endDate: string; order: number; }
export interface WorkoutDay { id?: number; stageId: number; dayOfWeek: number; name: string; focus: string; }

export interface Exercise { 
  id?: number; 
  name: string; 
  equipment: string; 
  instructions: string; 
  muscleGroup?: string;
  regression?: string; 
  progression?: string; 
}

export interface WorkoutExercise { id?: number; workoutDayId: number; exerciseId: number; order: number; sets: number; minReps: number; maxReps: number; targetWeight: number; restSeconds: number; }
export interface WorkoutSession { id?: number; date: string; workoutDayId: number; duration: number; completed: boolean; }
export interface SetRecord { id?: number; sessionId: number; exerciseId: number; setNumber: number; reps: number; weight: number; rir: number; }

export class WorkoutDatabase extends Dexie {
  userProfile!: Table<UserProfile, number>;
  stages!: Table<Stage, number>;
  workoutDays!: Table<WorkoutDay, number>;
  exercises!: Table<Exercise, number>;
  workoutExercises!: Table<WorkoutExercise, number>;
  workoutSessions!: Table<WorkoutSession, number>;
  setRecords!: Table<SetRecord, number>;

  constructor() {
    super('PraxisEvoDB');
    this.version(1).stores({
      userProfile: '++id',
      stages: '++id, order',
      workoutDays: '++id, stageId, dayOfWeek',
      exercises: '++id, name',
      workoutExercises: '++id, workoutDayId, exerciseId, order',
      workoutSessions: '++id, date, workoutDayId',
      setRecords: '++id, sessionId, exerciseId'
    });
  }
}

export const db = new WorkoutDatabase();