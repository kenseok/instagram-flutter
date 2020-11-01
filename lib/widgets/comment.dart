import 'package:flutter/material.dart';
import 'package:instagram_kenseok_app/constants/size.dart';
import 'package:instagram_kenseok_app/utils/profile_img_path.dart';

class Comment extends StatelessWidget {
  final String username;
  final bool showProfile;
  final DateTime dateTime;
  final String caption;

  const Comment(
      {Key key,
      @required this.username,
      this.showProfile = false,
      this.dateTime,
      @required this.caption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: showProfile,
          child: CircleAvatar(
            backgroundImage: NetworkImage(getProfileImgPath(username)),
            radius: profile_radius,
          ),
        ),
        Visibility(
            visible: showProfile,
            child: SizedBox(
              width: common_xs_gap,
            )),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context)
                        .style, //context란 현재 보여지고 있는 상태(정보)를 나타낸다.
                    children: <TextSpan>[
                      TextSpan(
                          text: username,
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: caption,
                      )
                    ]),
              ),
              SizedBox(
                height: common_xxxs_gap,
              ),
              Visibility(
                  visible: dateTime != null,
                  child: dateTime == null
                      ? SizedBox()
                      : Text(
                          dateTime.toIso8601String(),
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 10),
                        )),
            ],
          ),
        ),
      ],
    );
  }
}
