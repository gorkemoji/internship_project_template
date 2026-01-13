import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../constant/application_colors.dart';
import '../../../viewmodel/ai_call_viewmodel.dart';
import '../../widget/call/call_controls.dart';
import '../../widget/call/pulsing_avatar.dart';

class AiCallScreen extends StatelessWidget {
  const AiCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AiCallViewModel(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          body: Consumer<AiCallViewModel>(
            builder: (context, viewModel, child) {
              if (!viewModel.isPremium && !viewModel.isLoadingData && viewModel.aiState != AiState.connecting && viewModel.durationString == "00:00") {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  viewModel.endCallAutomatically(context);
                });
              }

              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      ApplicationColors.accent,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      const Text(
                        "Lingo",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.aiState == AiState.connecting
                            ? "Bağlanıyor..."
                            : viewModel.durationString,
                        style: TextStyle(
                          color: (!viewModel.isPremium && viewModel.durationString.startsWith("00:0"))
                              ? Colors.redAccent
                              : Colors.white.withValues(alpha: 0.8),
                          fontSize: 20,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PulsingAvatar(aiState: viewModel.aiState),

                            const SizedBox(height: 40),

                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 300),
                              opacity: viewModel.aiState == AiState.listening ? 1.0 : 0.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.graphic_eq, color: Colors.white, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      "Dinliyor...",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      CallControls(viewModel: viewModel),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}