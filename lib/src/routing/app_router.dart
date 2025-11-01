import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:workouttracker/src/features/exercises/presentation/exercise_details_screen.dart';
import 'package:workouttracker/src/features/exercises/presentation/exercise_form_screen.dart';
import 'package:workouttracker/src/features/exercises/presentation/exercises_screen.dart';
import 'package:workouttracker/src/features/history/presentation/history_screen.dart';
import 'package:workouttracker/src/features/session/presentation/session_screen.dart';
import 'package:workouttracker/src/features/settings/presentation/settings_screen.dart';
import 'package:workouttracker/src/features/templates/presentation/templates_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/exercises',
    routes: [
      GoRoute(
        path: '/exercises',
        builder: (context, state) => const ExercisesScreen(),
        routes: [
          GoRoute(
            path: 'new',
            builder: (context, state) => const ExerciseFormScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) =>
                ExerciseDetailsScreen(id: state.pathParameters['id']!),
          ),
        ],
      ),
      GoRoute(
        path: '/session/:sessionId',
        builder: (context, state) =>
            SessionScreen(sessionId: state.pathParameters['sessionId']!),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/templates',
        builder: (context, state) => const TemplatesScreen(),
      ),
    ],
    redirect: (context, state) {
      return null; // No auth for now
    },
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(state.error.toString())),
    ),
  );
});
