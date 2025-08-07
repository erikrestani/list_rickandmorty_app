import 'package:flutter/material.dart';
import 'package:list_rickandmorty_app/core/di/injection_container.dart';
import 'package:list_rickandmorty_app/core/theme/app_theme.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/viewmodels/welcome_viewmodel.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/load_characters_button.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/welcome_content.dart';
import 'package:list_rickandmorty_app/features/welcome/presentation/widgets/welcome_footer.dart';
import 'package:list_rickandmorty_app/shared/error_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final WelcomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = sl<WelcomeViewModel>();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Spacer(),
                  Image.asset(
                    'assets/photos/welcome_photo.png',
                    width: 500,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 32),
                  const WelcomeContent(),
                  const SizedBox(height: 32),
                  if (_viewModel.errorMessage != null) ...[
                    ErrorDisplayWidget(
                      errorMessage: _viewModel.errorMessage!,
                      onRetry: () => _viewModel.retry(context),
                    ),
                    const SizedBox(height: 20),
                  ],
                  LoadCharactersButton(
                    isLoading: _viewModel.isLoading,
                    onPressed: () => _viewModel.loadCharactersAndNavigate(context),
                  ),
                  const Spacer(),
                  const WelcomeFooter(),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
