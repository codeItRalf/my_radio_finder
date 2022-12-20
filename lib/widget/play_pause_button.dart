import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_radio_finder/cubit/radio_player_cubit.dart';
import 'package:my_radio_finder/model/radio_station.dart';

class PlayPauseButton extends StatefulWidget {
  const PlayPauseButton({
    Key? key,
    required this.station, this.color, this.size = 48.0,
  }) : super(key: key);

  final RadioStation station;
  final Color? color;
  final double size;

  @override
  State<PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton>
    with TickerProviderStateMixin {
  late Animation<double> _myAnimation;
  late AnimationController _controller;
  late RadioPlayerCubit _playerCubit;

  @override
  void initState() {
    _playerCubit = context.read<RadioPlayerCubit>();
    final state = _playerCubit.state;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _myAnimation = CurvedAnimation(curve: Curves.linear, parent: _controller);
    if (_playerCubit.state.station == widget.station &&
        state is RadioPlayerSuccess &&
        state.playerState == PlayerState.play) {
      _controller.value = _controller.upperBound;
    }

    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RadioPlayerCubit, RadioPlayerState>(
      listener: (context, state) {
        if (state is RadioPlayerLoading) {
          if (state.station == widget.station) {
            if (state.playerState == PlayerState.play) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
          } else {
            if (_controller.value == _controller.upperBound) {
              _controller.reverse();
            }
          }
        }
      },
      builder: (context, state) {
        final isLoading =
            state is RadioPlayerLoading && state.station == widget.station;
        final isPlaying = state.station == widget.station &&
            state is RadioPlayerSuccess &&
            state.playerState == PlayerState.play;

        return InkWell(
          onTap: () {
            if (isLoading || isPlaying) {
              _playerCubit.pause();
            } else {
              _playerCubit.play(station: widget.station);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isLoading) const CircularProgressIndicator(),
              AnimatedIcon(
                color: widget.color,
                  icon: AnimatedIcons.play_pause,
                  size: widget.size,
                  progress: _myAnimation),
            ],
          ),
        );
      },
    );
  }
}
