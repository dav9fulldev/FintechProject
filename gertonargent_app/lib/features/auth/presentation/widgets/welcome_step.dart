import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/onboarding_provider.dart';
import '../../../../data/local/registration_cache.dart';
import '../../../../data/services/api_service.dart';
import '../../providers/auth_provider.dart';
import '../../../navigation/main_navigation.dart';

class WelcomeStep extends ConsumerWidget {
  const WelcomeStep({super.key});

  Future<void> _finishOnboarding(BuildContext context, WidgetRef ref) async {
    final onboardingData = ref.read(onboardingProvider);

    // Afficher loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00A86B),
        ),
      ),
    );

    try {
      // Use data from onboarding provider
      final email = onboardingData.email!;
      final password = onboardingData.password!;
      final firstName = onboardingData.firstName;
      final lastName = onboardingData.lastName;
      final phone = onboardingData.fullPhoneNumber;
      final profession = onboardingData.profession;
      final incomeRange = onboardingData.incomeRange;
      final goals = onboardingData.goals;
      final categories = onboardingData.categories;

      // Enregistrer l'utilisateur avec toutes les données via ApiService
      final api = ref.read(apiServiceProvider);
      final payload = {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        if (phone != null) 'phone': phone,
        'profession': profession,
        'income_range': incomeRange,
        'goals': goals,
        'spending_categories': categories,
      };

      try {
        await api.registerWithPayload(payload);
        // after successful registration, login to obtain token and user
        final logged = await ref
            .read(authProvider.notifier)
            .login(email: email, password: password);
        if (logged) {
          await RegistrationCache.clear();
        }
      } catch (e) {
        throw e;
      }

      // Fermer le loading
      if (context.mounted) {
        Navigator.pop(context);

        // Naviguer vers le dashboard
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigation()),
          (route) => false,
        );
      }
    } catch (e) {
      // Fermer le loading
      if (context.mounted) {
        Navigator.pop(context);

        // Afficher l'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingData = ref.watch(onboardingProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF00A86B), Color(0xFF00D084)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animation (simple pour l'instant)
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '✨',
                    style: TextStyle(fontSize: 100),
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Message de bienvenue
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Text(
                      'Bienvenue ${onboardingData.firstName} !',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'sur GèrTonArgent',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Icône fusée
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: const Text(
                  '🚀',
                  style: TextStyle(fontSize: 80),
                ),
              ),

              const Spacer(),

              // Bouton Commencer
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1400),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _finishOnboarding(context, ref),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF00A86B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'Commencer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
