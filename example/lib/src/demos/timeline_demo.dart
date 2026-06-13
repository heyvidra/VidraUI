part of '../../main.dart';

class _TimeLineDemo extends StatelessWidget {
  const _TimeLineDemo();

  @override
  Widget build(BuildContext context) {
    return VFlex.vertical(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      gap: 16,
      children: [
        const VText('TimeLine', variant: VTextVariant.heading),
        const VText(
          'Vertical event timeline with status nodes.',
          variant: VTextVariant.caption,
        ),

        // Order tracking
        VSurface(
          variant: VSurfaceVariant.card,
          child: VTimeLine(
            items: [
              VTimeLineItem(
                title: _ItemTitle('Order placed'),
                subtitle: _ItemSub('2024-06-01 10:30'),
                description: _ItemDesc('Your order #1234 has been confirmed.'),
                status: VTimeLineStatus.completed,
              ),
              VTimeLineItem(
                title: _ItemTitle('Payment verified'),
                subtitle: _ItemSub('2024-06-01 10:32'),
                status: VTimeLineStatus.completed,
              ),
              VTimeLineItem(
                title: _ItemTitle('Preparing shipment'),
                subtitle: _ItemSub('2024-06-01 14:00'),
                description: _ItemDesc('Warehouse is packing your items.'),
                status: VTimeLineStatus.active,
              ),
              VTimeLineItem(
                title: _ItemTitle('Out for delivery'),
                subtitle: _ItemSub('Expected 2024-06-03'),
                status: VTimeLineStatus.pending,
              ),
              VTimeLineItem(
                title: _ItemTitle('Delivered'),
                subtitle: _ItemSub('—'),
                status: VTimeLineStatus.pending,
              ),
            ],
          ),
        ),

        // Error state
        VSurface(
          variant: VSurfaceVariant.card,
          child: VTimeLine(
            items: [
              VTimeLineItem(
                title: _ItemTitle('Build #142 — passed'),
                status: VTimeLineStatus.completed,
              ),
              VTimeLineItem(
                title: _ItemTitle('Build #143 — passed'),
                status: VTimeLineStatus.completed,
              ),
              VTimeLineItem(
                title: _ItemTitle('Build #144 — failed'),
                subtitle: _ItemSub('3 tests failed, 1 timeout'),
                status: VTimeLineStatus.error,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ItemTitle extends StatelessWidget {
  const _ItemTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) =>
      VText(text, variant: VTextVariant.label);
}

class _ItemSub extends StatelessWidget {
  const _ItemSub(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => VText(
        text,
        variant: VTextVariant.caption,
        color: VTheme.of(context).colors.textMuted,
      );
}

class _ItemDesc extends StatelessWidget {
  const _ItemDesc(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => VText(text, variant: VTextVariant.body);
}
