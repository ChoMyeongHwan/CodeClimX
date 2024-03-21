import 'package:codeclimx/community/screens/community_screen.dart';
import 'package:codeclimx/home/home_screen.dart';
import 'package:codeclimx/quiz/screens/quiz_screen.dart';
import 'package:codeclimx/videos/authentication/login_screen.dart';
import 'package:codeclimx/videos/authentication/repos/authentication_repo.dart';
import 'package:codeclimx/videos/authentication/sign_up_screen.dart';
import 'package:codeclimx/videos/curriculum/roadmap_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  // ref.watch(authState);

  return GoRouter(
    initialLocation: "/home",
    // initialLocation: "/",

    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;

      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: HomeScreen.routeURL,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: RoadmapScreen.routeName,
        path: RoadmapScreen.routeURL,
        builder: (context, state) => const RoadmapScreen(),
      ),
      GoRoute(
        name: QuizScreen.routeName,
        path: QuizScreen.routeURL,
        builder: (context, state) => const QuizScreen(),
      ),
      GoRoute(
        name: CommunityScreen.routeName,
        path: CommunityScreen.routeURL,
        builder: (context, state) => const CommunityScreen(),
      ),
    ],
  );
});
