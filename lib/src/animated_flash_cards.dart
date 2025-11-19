import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FlashCard extends StatefulWidget {
  final double cardHeight;
  final EdgeInsets? margin;
  final List<Widget> bottomPages;
  final List<Widget> topPages;
  final Color headerColor;
  final Color bottomColor;
  final Color topPageColor;
  final Color bottomPageColor;
  final double borderRadiusAll;
  const FlashCard({
    super.key,
    this.cardHeight = 200,
    required this.topPages,
    required this.bottomPages,
    this.margin,
    this.headerColor = Colors.amber,
    this.bottomColor = Colors.amber,
    this.topPageColor = Colors.amber,
    this.bottomPageColor = Colors.amber,
    this.borderRadiusAll = 20,
  }) : assert(
         topPages.length == bottomPages.length,
         'topPages and bottomPages must have the same number of items!',
       );

  @override
  State<FlashCard> createState() => _ChapterVersesScreenState();
}

class _ChapterVersesScreenState extends State<FlashCard>
    with SingleTickerProviderStateMixin {
  double verticalDrag = 0;
  double verticalDragTop = 0;
  int _currentIndex = 0;
  double startDy = 0;
  bool isDraggingUp = false;
  bool isDraggingDown = false;
  bool isTopFlipping = false;
  bool isTopFlipEndProcess = false;
  bool isTabForPaging = false;
  late String index;
  int delayPage = 200;
  bool isPressed = false;
  bool isDragContinue = false;
  bool isScrollEnd = false;

  Timer? _timer;
  Timer? _timerUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          widget.margin ?? EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            child: (_currentIndex > 0)
                ? InkWell(
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: isTopFlipEndProcess || (_currentIndex <= 0)
                        ? null
                        : () {
                            isTopFlipEndProcess = true;
                            isDraggingDown = true;
                            verticalDragTop = 0;
                            _timerUp = Timer.periodic(
                              Duration(milliseconds: 20),
                              (timer) {
                                verticalDragTop += 20;
                                if (verticalDragTop < 180) {
                                  setState(() {});
                                } else {
                                  verticalDragTop = 180;
                                  setState(() {});
                                  _timerUp?.cancel();
                                  isTopFlipEndProcess = false;
                                  verticalDragTop = 0;
                                  isDraggingDown = false;
                                  isTopFlipping = false;

                                  _currentIndex--;
                                  setState(() {});
                                }
                              },
                            );
                          },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: widget.headerColor.withValues(alpha: .5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.borderRadiusAll),
                          topRight: Radius.circular(widget.borderRadiusAll),
                        ),
                      ),
                      height: widget.cardHeight,
                      width: double.infinity,
                    ),
                  )
                : SizedBox.shrink(),
          ),

          AnimatedSwitcher(
            duration: Duration(milliseconds: 350),
            child: (_currentIndex > 0)
                ? InkWell(
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: isTopFlipEndProcess || (_currentIndex <= 0)
                        ? null
                        : () {
                            isTopFlipEndProcess = true;
                            isDraggingDown = true;
                            verticalDragTop = 0;
                            _timerUp = Timer.periodic(
                              Duration(milliseconds: 20),
                              (timer) {
                                verticalDragTop += 20;
                                if (verticalDragTop < 180) {
                                  setState(() {});
                                } else {
                                  verticalDragTop = 180;
                                  setState(() {});
                                  _timerUp?.cancel();
                                  isTopFlipEndProcess = false;
                                  verticalDragTop = 0;
                                  isDraggingDown = false;
                                  isTopFlipping = false;

                                  _currentIndex--;
                                  setState(() {});
                                }
                              },
                            );
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.headerColor.withValues(alpha: .25),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.borderRadiusAll),
                          topRight: Radius.circular(widget.borderRadiusAll),
                        ),
                      ),
                      height: 200,
                      width: double.infinity,
                    ),
                  )
                : SizedBox.shrink(),
          ),

          //* Top card flip--
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: widget.topPageColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.borderRadiusAll),
                      topRight: Radius.circular(widget.borderRadiusAll),
                    ),
                  ),
                  child: widget.topPages.elementAtOrNull(
                    verticalDragTop > 0 ? _currentIndex - 1 : _currentIndex,
                  ),
                ),
              ),
              _bottomFlip(widget.bottomPages, widget.topPages),
            ],
          ),
          //* bottom Card
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: isDragContinue || isTopFlipEndProcess
                      ? null
                      : (details) {
                          isTopFlipping = true;
                          if (_currentIndex == 0) {
                            return;
                          }
                          if (verticalDragTop >= 180) {
                            verticalDragTop = 180;
                            return;
                          }
                          verticalDragTop += details.delta.dy;

                          if (!isDraggingDown && verticalDragTop == 0) {
                            isDraggingDown = details.delta.dy < 0;
                          }
                          if (!isDraggingDown && verticalDragTop < 0) {
                            verticalDragTop = 0;
                            isDraggingDown = false;
                            setState(() {});
                            return;
                          }
                          if (!isDraggingDown && verticalDragTop > 180) {
                            verticalDragTop = 180;
                            isDraggingDown = false;
                            setState(() {});
                            return;
                          }

                          verticalDragTop %= 180;
                          verticalDragTop = verticalDragTop.clamp(0, 180.0);
                          setState(() {});
                        },
                  onVerticalDragEnd: isDragContinue || isTopFlipEndProcess
                      ? null
                      : (details) {
                          isTopFlipEndProcess = true;
                          if (verticalDragTop < 20) {
                            _timerUp = Timer.periodic(
                              Duration(milliseconds: 10),
                              (timer) {
                                verticalDragTop -= 20;
                                if (verticalDragTop > 0) {
                                  setState(() {});
                                } else {
                                  _timerUp?.cancel();
                                  isTopFlipEndProcess = false;
                                  verticalDragTop = 0;
                                  isDraggingDown = false;
                                  isTopFlipping = false;
                                  setState(() {});
                                }
                              },
                            );
                          } else {
                            _timerUp = Timer.periodic(
                              Duration(milliseconds: 10),
                              (timer) {
                                verticalDragTop += 20;
                                if (verticalDragTop < 180) {
                                  setState(() {});
                                } else {
                                  verticalDragTop = 180;
                                  setState(() {});
                                  _timerUp?.cancel();
                                  isTopFlipEndProcess = false;
                                  verticalDragTop = 0;
                                  isDraggingDown = false;
                                  isTopFlipping = false;

                                  _currentIndex--;
                                  setState(() {});
                                }
                              },
                            );
                          }
                        },
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX((verticalDragTop / (180) * pi)),
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ).copyWith(top: 14),
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: verticalDragTop > 0
                            ? widget.bottomPageColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.borderRadiusAll),
                          topRight: Radius.circular(widget.borderRadiusAll),
                        ),
                      ),
                      child: verticalDragTop > 0
                          ? verticalDragTop > 90
                                ? Transform.flip(
                                    flipY: true,
                                    child: widget.bottomPages.elementAtOrNull(
                                      _currentIndex - 1,
                                    ),
                                  )
                                : widget.topPages.elementAtOrNull(_currentIndex)
                          : Center(),
                    ),
                  ),
                ),
              ),
              Expanded(child: Center()),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _bottomFlip(List<Widget> pages, List<Widget> topPages) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          pages.length > 1 && _currentIndex < pages.length - 1
              ? Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                      .copyWith(
                        top: (verticalDrag == 0 || verticalDrag == 360)
                            ? 14
                            : 0,
                        bottom: (verticalDrag == 0 || verticalDrag == 360)
                            ? 14
                            : 10,
                      ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: verticalDrag == 0 || verticalDrag == 360
                        ? widget.bottomPageColor.withValues(alpha: .5)
                        : widget.bottomPageColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(widget.borderRadiusAll),
                      bottomRight: Radius.circular(widget.borderRadiusAll),
                    ),
                  ),
                  child: verticalDrag > 0
                      ? pages.elementAtOrNull(_currentIndex + 1)
                      : Center(),
                )
              : Center(),
          pages.length > 1 && _currentIndex < pages.length - 1
              ? InkWell(
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: isPressed || isDragContinue || isTopFlipping
                      ? null
                      : () async {
                          if (pages.length > 1 &&
                              _currentIndex < pages.length - 1) {
                            isPressed = true;
                            if (_currentIndex >= pages.length - 1) {
                              await Future.delayed(Duration(milliseconds: 500));
                              isPressed = false;
                              return;
                            }
                            verticalDrag = 360;
                            _timer = Timer.periodic(
                              Duration(milliseconds: 15),
                              (timer) {
                                verticalDrag = verticalDrag - 10;
                                setState(() {});

                                if (verticalDrag < 180) {
                                  _timer?.cancel();
                                  _currentIndex++;
                                  verticalDrag = 0;
                                  isPressed = false;
                                  setState(() {});
                                }
                              },
                            );
                          }
                        },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.bottomPageColor.withValues(alpha: .25),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(widget.borderRadiusAll),
                        bottomRight: Radius.circular(widget.borderRadiusAll),
                      ),
                    ),
                  ),
                )
              : Center(),

          GestureDetector(
            onTap: isPressed || isDragContinue || isTopFlipping
                ? null
                : () async {
                    isPressed = true;
                    if (_currentIndex >= pages.length - 1) {
                      await Future.delayed(Duration(milliseconds: 500));
                      isPressed = false;
                      return;
                    }
                    verticalDrag = 360;
                    _timer = Timer.periodic(Duration(milliseconds: 15), (
                      timer,
                    ) {
                      verticalDrag = verticalDrag - 20;
                      setState(() {});

                      if (verticalDrag < 180) {
                        _timer?.cancel();
                        _currentIndex++;
                        verticalDrag = 0;
                        isPressed = false;
                        setState(() {});
                      }
                    });
                  },
            onVerticalDragStart: isPressed || isDragContinue || isTopFlipping
                ? null
                : (details) {
                    startDy = details.globalPosition.dy;
                    verticalDrag = 0;
                    isDraggingUp = false;
                  },
            onVerticalDragUpdate: isPressed || isDragContinue || isTopFlipping
                ? null
                : (details) {
                    if (_currentIndex >= pages.length - 1) {
                      return;
                    }

                    // Determine direction only once
                    if (!isDraggingUp && verticalDrag == 0) {
                      isDraggingUp = details.delta.dy < 0;
                    }

                    // If dragging down instead of up, ignore
                    if (!isDraggingUp && verticalDrag == 0) {
                      return;
                    }
                    if (!isDraggingUp && details.delta.dy > 0) {
                      return;
                    }

                    if (isDraggingUp &&
                        details.delta.dy > 0 &&
                        (verticalDrag + details.delta.dy) > 355) {
                      return;
                    }
                    verticalDrag += details.delta.dy;
                    verticalDrag %= 360;
                    verticalDrag = verticalDrag.clamp(180, 360.0);

                    if ((verticalDrag > 360 &&
                            (verticalDrag + details.delta.dy) < verticalDrag) ||
                        verticalDrag < 60) {
                      verticalDrag = 360;
                    } else {
                      setState(() {});
                    }
                  },
            onVerticalDragEnd: isPressed || isDragContinue
                ? null
                : (details) {
                    if (verticalDrag != 0 && verticalDrag < 360) {
                      isDragContinue = true;
                      if (verticalDrag > 340) {
                        _timer = Timer.periodic(Duration(milliseconds: 10), (
                          timer,
                        ) {
                          verticalDrag = verticalDrag + 20;
                          setState(() {});
                          if (verticalDrag >= 360) {
                            _timer?.cancel();
                            verticalDrag = 360;
                            isDragContinue = false;
                            setState(() {});
                          }
                        });
                      } else {
                        _timer = Timer.periodic(Duration(milliseconds: 10), (
                          timer,
                        ) {
                          verticalDrag = verticalDrag - 20;
                          setState(() {});
                          if (verticalDrag <= 180) {
                            _timer?.cancel();
                            _currentIndex++;
                            verticalDrag = 0;
                            isDragContinue = false;
                            setState(() {});
                          }
                        });
                      }
                    }
                  },
            child: FlipCard(
              borderRadiusAll: widget.borderRadiusAll,
              bottomPageColor: widget.bottomPageColor,
              topPageColor: widget.topPageColor,
              isShowCardFlip:
                  pages.length > 1 && _currentIndex < pages.length - 1,
              verticalDrag: verticalDrag,
              pages: pages,
              topPages: topPages,
              currentIndex: _currentIndex,
              onVerseTap: isPressed || isDragContinue || isTopFlipping
                  ? () {}
                  : () async {
                      isPressed = true;
                      if (_currentIndex >= pages.length - 1) {
                        await Future.delayed(Duration(milliseconds: 500));
                        isPressed = false;
                        return;
                      }
                      verticalDrag = 360;
                      _timer = Timer.periodic(Duration(milliseconds: 15), (
                        timer,
                      ) {
                        verticalDrag = verticalDrag - 20;
                        setState(() {});

                        if (verticalDrag < 180) {
                          _timer?.cancel();
                          _currentIndex++;
                          verticalDrag = 0;
                          isPressed = false;
                          setState(() {});
                        }
                      });
                    },
            ),
          ),
        ],
      ),
    );
  }
}

Column _verseImageContent({required Widget child}) {
  return Column(
    children: [
      Row(children: [SizedBox(height: 10)]),

      Expanded(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: child,
        ),
      ),
    ],
  );
}

class FlipCard extends StatelessWidget {
  const FlipCard({
    super.key,
    required this.verticalDrag,
    required this.pages,
    required this.topPages,
    required int currentIndex,
    this.isUpCard = false,
    this.isShowCardFlip = false,
    required this.onVerseTap,
    required this.topPageColor,
    required this.bottomPageColor,
    required this.borderRadiusAll,
  }) : _currentIndex = currentIndex;

  final double verticalDrag;
  final List pages;
  final List topPages;
  final int _currentIndex;
  final bool isUpCard;
  final bool isShowCardFlip;
  final Color topPageColor;
  final Color bottomPageColor;
  final Function() onVerseTap;
  final double borderRadiusAll;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.topCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX((verticalDrag / (180) * pi)),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: isUpCard ? 0 : 40),

            width: double.infinity,

            child: ClipRRect(
              borderRadius: isUpCard
                  ? BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusAll),
                      topRight: Radius.circular(borderRadiusAll),
                    )
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadiusAll),
                      bottomRight: Radius.circular(borderRadiusAll),
                    ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    color: Colors.transparent,

                    child:
                        (verticalDrag > 0 && verticalDrag < 360) &&
                            verticalDrag < 270
                        ? Container(
                            color: topPageColor,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Transform.flip(
                              flipY: true,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: _verseImageContent(
                                  child: topPages.elementAtOrNull(
                                    _currentIndex + 1,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : VerseContent(
                            bottomPageColor: bottomPageColor,
                            isUpCard: isUpCard,
                            isShowCardFlip:
                                isShowCardFlip && _currentIndex == 0,
                            child: pages.elementAtOrNull(_currentIndex),
                            onVerseTap: () {
                              onVerseTap();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerseContent extends StatefulWidget {
  final Function()? onVerseTap;

  final bool? isUpCard, isShowCardFlip;
  final Color bottomPageColor;
  final Widget child;
  const VerseContent({
    super.key,
    this.onVerseTap,
    this.isUpCard,
    this.isShowCardFlip,
    required this.bottomPageColor,
    required this.child,
  });

  @override
  State<VerseContent> createState() => _VerseContentState();
}

class _VerseContentState extends State<VerseContent> {
  bool isScrollableContent = false;
  int attemptTime = 0;
  Timer? _debounce;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: widget.bottomPageColor,
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is OverscrollNotification) {
            final metrics = scrollNotification.metrics;

            // Only trigger if already at the end
            if (metrics.pixels >= metrics.maxScrollExtent) {
              if (attemptTime == 1) {
                attemptTime = 0;
                widget.onVerseTap?.call();
              }
              _debounce?.cancel();

              // Start a new timer (e.g., 300ms)
              _debounce = Timer(Duration(milliseconds: 100), () {
                attemptTime = 1;
              });
            } else {
              attemptTime = 0;
            }
          }
          return false;
        },
        child: Column(
          children: [
            Row(),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
