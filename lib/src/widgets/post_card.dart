import 'package:flutter/material.dart';
import 'package:instagram_clone/src/providers/user_provider.dart';
import 'package:instagram_clone/src/resources/firestore_methods.dart';
import 'package:instagram_clone/src/share/constant.dart';
import 'package:instagram_clone/src/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({required this.snap, super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUser;
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(widget.snap['profImage']),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.snap['username'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shrinkWrap: true,
                              children: ['Delete']
                                  .map((e) => InkWell(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 16),
                                          child: Text(e),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(widget.snap['postId'], widget.snap['uid'], widget.snap['likes']);
              setState(() {
                isLikeAnimating = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap['postUrl'],
                    fit: BoxFit.cover,
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(milliseconds: 400),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 120,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user!.uid),
                smallLike: true,
                child: IconButton(
                    onPressed: () async => await FireStoreMethods()
                        .likePost(widget.snap['postId'], widget.snap['uid'], widget.snap['likes']),
                    icon: widget.snap['likes'].contains(user.uid)
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_outlined,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                  )),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_border,
                  )),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.snap['likes'].length} like',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(style: const TextStyle(color: primaryColor), children: [
                      TextSpan(text: widget.snap['username'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '\t ${widget.snap['description']}')
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: const Text(
                      'View all 200 comments',
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    DateFormat.yMMMd().format(DateTime.parse(widget.snap['datePublished'])),
                    style: const TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
