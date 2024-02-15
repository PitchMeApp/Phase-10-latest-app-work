import 'package:flutter/material.dart';
import 'package:pitch_me_app/utils/extras/extras.dart';
import 'package:pitch_me_app/utils/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Phase 6/Guest UI/Profile/manu.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/sizeConfig/sizeConfig.dart';
import '../../../utils/strings/images.dart';
import '../../../utils/widgets/Navigation/custom_navigation.dart';
import '../../../utils/widgets/containers/containers.dart';
import '../../../utils/widgets/extras/backgroundWidget.dart';
import '../../Custom header view/appbar_with_white_bg.dart';
import '../../Custom header view/new_bottom_bar.dart';
import '../manu.dart';

class FQAPage extends StatefulWidget {
  int pageIndex;
  int isCheckPro;
  FQAPage({
    super.key,
    required this.pageIndex,
    required this.isCheckPro,
  });

  @override
  State<FQAPage> createState() => _FQAPageState();
}

class _FQAPageState extends State<FQAPage> {
  String checkGuestType = '';

  int isCheck = 0;

  @override
  void initState() {
    checkGuest();
    super.initState();
  }

  void checkGuest() async {
    SharedPreferences preferencesData = await SharedPreferences.getInstance();
    setState(() {
      checkGuestType = preferencesData.getString('guest').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        backgroundImage: Assets.backgroundImage,
        bannerRequired: false,
        fit: BoxFit.fill,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          ClipPath(
                            clipper: CurveClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: DynamicColor.gradientColorChange),
                              height:
                                  MediaQuery.of(context).size.height * 0.235,
                            ),
                          ),
                          whiteBorderContainer(
                              child: Image.asset(Assets.handshakeImage),
                              color: Colors.transparent,
                              height: SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.12),
                              width: SizeConfig.getSizeHeightBy(
                                  context: context, by: 0.12),
                              cornerRadius: 25),
                        ],
                      ),
                    ],
                  ),
                ),
                listWidget(),
              ],
            ),
            CustomAppbarWithWhiteBg(
              title: 'FAQ',
              checkNext: 'back',
              onPressad: () {
                if (checkGuestType == 'null' && checkGuestType.isNotEmpty) {
                  PageNavigateScreen().push(
                      context,
                      GuestManuPage(
                        title: 'FAQ',
                        pageIndex: widget.pageIndex,
                      ));
                } else {
                  PageNavigateScreen().push(
                      context,
                      ManuPage(
                        title: 'FAQ',
                        pageIndex: widget.pageIndex,
                        isManu: 'Manu',
                      ));
                }
              },
            ),
            NewCustomBottomBar(
              index: widget.pageIndex,
              isBack: checkGuestType == 'null' ? 'Guest' : true,
            ),
          ],
        ),
      ),
    );
  }

  Widget listWidget() {
    return Expanded(
      flex: 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            questionFaq(
              1,
              'What is this App for?',
              onTap: () {
                setState(() {
                  if (isCheck == 1) {
                    isCheck = 0;
                  } else {
                    isCheck = 1;
                  }
                });
              },
            ),
            isCheck != 1
                ? Container()
                : ansFaq(
                    'We help Businesses, Investors and service providers to find each other and close a deal.'),
            questionFaq(
              2,
              'Who is this app for?',
              onTap: () {
                setState(() {
                  if (isCheck == 2) {
                    isCheck = 0;
                  } else {
                    isCheck = 2;
                  }
                });
              },
            ),
            isCheck != 2
                ? Container()
                : ansFaq(
                    '''• Businesses: Looking to make their idea a reality or improve, expand or sell their established business.
• ⁠Investors: Want to find good deals to make a profit.
• ⁠Service Providers: Freelancer or Companies. e.g. Marketing, Lawyer, Web Developers, etc'''),
            questionFaq(
              3,
              ' What is a Service Provider?',
              onTap: () {
                setState(() {
                  if (isCheck == 3) {
                    isCheck = 0;
                  } else {
                    isCheck = 3;
                  }
                });
              },
            ),
            isCheck != 3
                ? Container()
                : ansFaq(
                    '''Individuals or Companies that helps Businesses in exchange of Shares or Payment.
• Skill: Sales, Coding, managing.
• ⁠Services: Marketing, Engineer, Lawyer.
• ⁠Connection: An Introduction to someone that makes all difference'''),
            questionFaq(
              4,
              'What is the Biography for?',
              onTap: () {
                setState(() {
                  if (isCheck == 4) {
                    isCheck = 0;
                  } else {
                    isCheck = 4;
                  }
                });
              },
            ),
            isCheck != 4
                ? Container()
                : ansFaq(
                    'It adds more information about you, including officially verifies important things like your ID, Face confirmation, Funds proof, and even certificate of skills.'),
            questionFaq(
              5,
              'What tools the app provides?',
              onTap: () {
                setState(() {
                  if (isCheck == 5) {
                    isCheck = 0;
                  } else {
                    isCheck = 5;
                  }
                });
              },
            ),
            isCheck != 5
                ? Container()
                : ansFaq(
                    'Business Advice and strategies, Posting Sales Pitch, Watching Pitches, Content Filter, NDA, Feedback, Biography, verification, chat'),
            questionFaq(
              6,
              'Any future features are being or will be added to the current ones?',
              onTap: () {
                setState(() {
                  if (isCheck == 6) {
                    isCheck = 0;
                  } else {
                    isCheck = 6;
                  }
                });
              },
            ),
            isCheck != 6
                ? Container()
                : ansFaq(
                    ''' Yes. We are always looking for new ways to help our users. Currently under development are the Features:\n
- Custom Smart Contract\n
- Investment Details\n
- Equity Shares Creation\n
- Escrow Account\n
- Trust fund Service\n
- CRM System\n
- Advertise in App\n
- Buy Pitch Me Shares\n
- Web Version\n
- Business Consultant\n

With many more on the waiting list.'''),
            questionFaq(
              7,
              'How to find out if the Business or an Investors is legit?',
              onTap: () {
                setState(() {
                  if (isCheck == 7) {
                    isCheck = 0;
                  } else {
                    isCheck = 7;
                  }
                });
              },
            ),
            isCheck != 7
                ? Container()
                : ansFaq(
                    'You must request the needful documentation and do your own due diligence.'),
            questionFaq(
              8,
              'Can someone steal my idea?',
              onTap: () {
                setState(() {
                  if (isCheck == 8) {
                    isCheck = 0;
                  } else {
                    isCheck = 8;
                  }
                });
              },
            ),
            isCheck != 8
                ? Container()
                : ansFaq(
                    '''When posting your sales pitch an option to only show it to Users who have signed an NDA and ID Proof is available for extra protection.\n
Good Ideas usually everyone has, its the execution that makes all the difference. Make sure you also have what it takes to make that business a reality.'''),
            questionFaq(
              9,
              'How to increase a chance to close a deal?',
              onTap: () {
                setState(() {
                  if (isCheck == 9) {
                    isCheck = 0;
                  } else {
                    isCheck = 9;
                  }
                });
              },
            ),
            isCheck != 9
                ? Container()
                : ansFaq(
                    '''- As the receiving side, you should have your Biography and the sales pitch the most complete possible and be quick to reply on chat.\n
- As the giving side you must filter what types of pitches do you want to see, have the biography complete and be quick to reply on chat.'''),
            widget.isCheckPro == 0
                ? Container()
                : questionFaq(
                    10,
                    'Is the App free?',
                    onTap: () {
                      setState(() {
                        if (isCheck == 10) {
                          isCheck = 0;
                        } else {
                          isCheck = 10;
                        }
                      });
                    },
                  ),
            widget.isCheckPro == 0
                ? Container()
                : isCheck != 10
                    ? Container()
                    : ansFaq(
                        'The app has many features that are complete free and some temporarily. The Paid version gives unlimited access to all Features that real Business people will require.'),
            questionFaq(
              11,
              'How did we come up with the concept?',
              onTap: () {
                setState(() {
                  if (isCheck == 11) {
                    isCheck = 0;
                  } else {
                    isCheck = 11;
                  }
                });
              },
            ),
            isCheck != 11
                ? Container()
                : ansFaq(
                    '''We saw the difficulty that aspiring and current entrepreneurs face to raise funds or find quality people to help on their Business ventures.\n
The limited business and investment opportunities also raised red flags, so we created an app that solves multiple problems on both sides of a deal.'''),
            spaceHeight(MediaQuery.of(context).size.height * 0.15),
          ],
        ),
      ),
    );
  }

  Widget questionFaq(int isSelect, String title,
      {required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(
          top: 5,
          left: SizeConfig.getSize25(context: context),
          right: SizeConfig.getSize25(context: context)),
      child: Card(
        elevation: isCheck == isSelect ? 0 : 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: onTap,
          leading: isCheck != isSelect
              ? Icon(
                  Icons.add,
                  color: DynamicColor.gredient2,
                  size: 40,
                )
              : Icon(Icons.remove, color: DynamicColor.redColor, size: 40),
          title: Text(
            title,
            style: textColor12,
          ),
        ),
      ),
    );
  }

  Widget ansFaq(title) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.getSize25(context: context),
          right: SizeConfig.getSize25(context: context)),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0xffF0EBEB),
        child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                title,
                style: textColor12,
                // maxLines: 1,
              ),
            )),
      ),
    );
  }
}
