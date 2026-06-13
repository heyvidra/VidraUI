part of '../../main.dart';

class _DemoContent extends StatelessWidget {
  const _DemoContent({required this.category});

  final _DemoCategory category;

  @override
  Widget build(BuildContext context) {
    final demo = _buildDemo(context, category);

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        final contentWidth =
            availableWidth > 32 ? availableWidth - 32 : availableWidth;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: contentWidth,
            child: _DocsPage(metadata: category.docs, demo: demo),
          ),
        );
      },
    );
  }
}

