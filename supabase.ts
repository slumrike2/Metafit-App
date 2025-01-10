export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  graphql_public: {
    Tables: {
      [_ in never]: never
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      graphql: {
        Args: {
          operationName?: string
          query?: string
          variables?: Json
          extensions?: Json
        }
        Returns: Json
      }
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
  public: {
    Tables: {
      equipment: {
        Row: {
          id: number
          name: string
          type: string
        }
        Insert: {
          id?: number
          name: string
          type: string
        }
        Update: {
          id?: number
          name?: string
          type?: string
        }
        Relationships: []
      }
      exercise_equipment: {
        Row: {
          equipment_id: number | null
          exercise_id: number | null
          id: number
        }
        Insert: {
          equipment_id?: number | null
          exercise_id?: number | null
          id?: number
        }
        Update: {
          equipment_id?: number | null
          exercise_id?: number | null
          id?: number
        }
        Relationships: [
          {
            foreignKeyName: "exercise_equipment_equipment_id_fkey"
            columns: ["equipment_id"]
            isOneToOne: false
            referencedRelation: "equipment"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "exercise_equipment_exercise_id_fkey"
            columns: ["exercise_id"]
            isOneToOne: false
            referencedRelation: "exercises"
            referencedColumns: ["id"]
          },
        ]
      }
      exercise_muscle_groups: {
        Row: {
          exercise_id: number | null
          id: number
          muscle_group_id: number | null
        }
        Insert: {
          exercise_id?: number | null
          id?: number
          muscle_group_id?: number | null
        }
        Update: {
          exercise_id?: number | null
          id?: number
          muscle_group_id?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "exercise_muscle_groups_exercise_id_fkey"
            columns: ["exercise_id"]
            isOneToOne: false
            referencedRelation: "exercises"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "exercise_muscle_groups_muscle_group_id_fkey"
            columns: ["muscle_group_id"]
            isOneToOne: false
            referencedRelation: "muscle_groups"
            referencedColumns: ["id"]
          },
        ]
      }
      exercises: {
        Row: {
          description: string
          difficulty: string
          id: number
          name: string
          type: string
        }
        Insert: {
          description: string
          difficulty: string
          id?: number
          name: string
          type: string
        }
        Update: {
          description?: string
          difficulty?: string
          id?: number
          name?: string
          type?: string
        }
        Relationships: []
      }
      muscle_group_muscles: {
        Row: {
          id: number
          muscle_group_id: number | null
          muscle_id: number | null
        }
        Insert: {
          id?: number
          muscle_group_id?: number | null
          muscle_id?: number | null
        }
        Update: {
          id?: number
          muscle_group_id?: number | null
          muscle_id?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "muscle_group_muscles_muscle_group_id_fkey"
            columns: ["muscle_group_id"]
            isOneToOne: false
            referencedRelation: "muscle_groups"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "muscle_group_muscles_muscle_id_fkey"
            columns: ["muscle_id"]
            isOneToOne: false
            referencedRelation: "muscles"
            referencedColumns: ["id"]
          },
        ]
      }
      muscle_groups: {
        Row: {
          id: number
          name: string
        }
        Insert: {
          id?: number
          name: string
        }
        Update: {
          id?: number
          name?: string
        }
        Relationships: []
      }
      muscles: {
        Row: {
          id: number
          name: string
        }
        Insert: {
          id?: number
          name: string
        }
        Update: {
          id?: number
          name?: string
        }
        Relationships: []
      }
      users: {
        Row: {
          birth_date: string
          created_at: string | null
          email: string
          experience: string
          full_name: string
          gender: string
          goal: string
          height: number
          id: number
          location: string
          password: string
          weight: number
        }
        Insert: {
          birth_date: string
          created_at?: string | null
          email: string
          experience: string
          full_name: string
          gender: string
          goal: string
          height: number
          id?: number
          location: string
          password: string
          weight: number
        }
        Update: {
          birth_date?: string
          created_at?: string | null
          email?: string
          experience?: string
          full_name?: string
          gender?: string
          goal?: string
          height?: number
          id?: number
          location?: string
          password?: string
          weight?: number
        }
        Relationships: []
      }
      workout_exercise_rating: {
        Row: {
          created_at: string | null
          exercise_rating: number
          id: number
          workout_exercise_id: number | null
        }
        Insert: {
          created_at?: string | null
          exercise_rating: number
          id?: number
          workout_exercise_id?: number | null
        }
        Update: {
          created_at?: string | null
          exercise_rating?: number
          id?: number
          workout_exercise_id?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "workout_exercise_rating_workout_exercise_id_fkey"
            columns: ["workout_exercise_id"]
            isOneToOne: false
            referencedRelation: "workout_exercises"
            referencedColumns: ["id"]
          },
        ]
      }
      workout_exercises: {
        Row: {
          distance: number | null
          duration: number | null
          exercise_id: number | null
          id: number
          reps: number
          sequence: number
          sets: number
          weight: number | null
          workout_id: number | null
        }
        Insert: {
          distance?: number | null
          duration?: number | null
          exercise_id?: number | null
          id?: number
          reps: number
          sequence: number
          sets: number
          weight?: number | null
          workout_id?: number | null
        }
        Update: {
          distance?: number | null
          duration?: number | null
          exercise_id?: number | null
          id?: number
          reps?: number
          sequence?: number
          sets?: number
          weight?: number | null
          workout_id?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "workout_exercises_exercise_id_fkey"
            columns: ["exercise_id"]
            isOneToOne: false
            referencedRelation: "exercises"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "workout_exercises_workout_id_fkey"
            columns: ["workout_id"]
            isOneToOne: false
            referencedRelation: "workouts"
            referencedColumns: ["id"]
          },
        ]
      }
      workout_rating: {
        Row: {
          created_at: string | null
          difficulty_rating: number
          id: number
          routine_rating: number
          workout_id: number | null
        }
        Insert: {
          created_at?: string | null
          difficulty_rating: number
          id?: number
          routine_rating: number
          workout_id?: number | null
        }
        Update: {
          created_at?: string | null
          difficulty_rating?: number
          id?: number
          routine_rating?: number
          workout_id?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "workout_rating_workout_id_fkey"
            columns: ["workout_id"]
            isOneToOne: false
            referencedRelation: "workouts"
            referencedColumns: ["id"]
          },
        ]
      }
      workouts: {
        Row: {
          created_at: string | null
          description: string
          difficulty: string
          equipment: string
          id: number
          name: string
          recomendation: number
          user_id: number | null
        }
        Insert: {
          created_at?: string | null
          description: string
          difficulty: string
          equipment: string
          id?: number
          name: string
          recomendation: number
          user_id?: number | null
        }
        Update: {
          created_at?: string | null
          description?: string
          difficulty?: string
          equipment?: string
          id?: number
          name?: string
          recomendation?: number
          user_id?: number | null
        }
        Relationships: [
          {
            foreignKeyName: "workouts_user_id_fkey"
            columns: ["user_id"]
            isOneToOne: false
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      [_ in never]: never
    }
    Enums: {
      [_ in never]: never
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof PublicSchema["CompositeTypes"]
    | { schema: keyof Database },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof Database
  }
    ? keyof Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never,
> = PublicCompositeTypeNameOrOptions extends { schema: keyof Database }
  ? Database[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof PublicSchema["CompositeTypes"]
    ? PublicSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never
