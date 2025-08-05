import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OrdemServicoSkeletonList extends StatelessWidget {
  const OrdemServicoSkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Shimmer(
            duration: const Duration(seconds: 2),       // duração do ciclo
            interval: const Duration(seconds: 0),       // sem intervalo entre ciclos
            color: Colors.white,                        // cor do brilho
            colorOpacity: 0.3,                          // opacidade do overlay branco
            enabled: true,                              // shimmer ativo
            direction: ShimmerDirection.fromLTRB(),     // movimento de luz da esquerda para direita
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(width: 40, height: 40, color: Colors.grey[300]),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 16,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 14,
                            width: MediaQuery.of(context).size.width * 0.6,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
