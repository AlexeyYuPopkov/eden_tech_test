import 'package:flutter/widgets.dart';

// final class SliverSizedBox {
//   final double width;
//   final double height;
//   final Widget? child;

//   const SliverSizedBox({
//     this.width = 0.0,
//     this.height = 0.0,
//     this.child,
//   });

//   Widget build() {
//     return SliverToBoxAdapter(
//       child: SizedBox(
//         height: height,
//         child: child,
//       ),
//     );
//   }
// }

class SliverSizedBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;

  const SliverSizedBox({
    super.key,
    this.width = 0.0,
    this.height = 0.0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: height,
        child: child,
      ),
    );
  }
}
