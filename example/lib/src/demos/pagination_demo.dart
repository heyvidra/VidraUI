part of '../../main.dart';

class _PaginationDemo extends StatefulWidget {
  const _PaginationDemo();
  @override
  State<_PaginationDemo> createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<_PaginationDemo> {
  int _page = 1;
  static const _total = 20;

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('Pagination', variant: VTextVariant.heading),
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VText(
                'Page $_page of $_total',
                variant: VTextVariant.body,
              ),
              VPagination(
                totalPages: _total,
                currentPage: _page,
                onPageChanged: (p) => setState(() => _page = p),
              ),
            ],
          ),
        ),
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VText(
                'Without arrows',
                variant: VTextVariant.label,
              ),
              VPagination(
                totalPages: _total,
                currentPage: _page,
                showArrows: false,
                onPageChanged: (p) => setState(() => _page = p),
              ),
            ],
          ),
        ),
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VText(
                'Small set — no ellipsis',
                variant: VTextVariant.label,
              ),
              VPagination(
                totalPages: 5,
                currentPage: (_page - 1) % 5 + 1,
                onPageChanged: (p) => setState(() => _page = p),
              ),
            ],
          ),
        ),
        VSurface(
          variant: VSurfaceVariant.card,
          child: VFlex.vertical(
            gap: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VText(
                'Disabled',
                variant: VTextVariant.label,
              ),
              VPagination(
                totalPages: _total,
                currentPage: 7,
                enabled: false,
                onPageChanged: (p) {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
