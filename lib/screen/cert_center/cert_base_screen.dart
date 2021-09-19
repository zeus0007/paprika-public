import 'package:flutter/material.dart';
import 'package:opena_front/arguments/cert_page_args.dart';
import 'package:opena_front/components/app_base.dart';
import 'package:opena_front/components/custom_stepper/custom_icon_stepper.dart';
// import 'package:im_stepper/stepper.dart';
import 'package:opena_front/screen/cert_center/cert_etc.dart';
import 'package:opena_front/screen/cert_center/cert_income.dart';
import 'package:opena_front/screen/cert_center/cert_investment.dart';
import 'package:opena_front/screen/cert_center/cert_saving.dart';

class CertBaseScreen extends StatefulWidget {
  static String id = 'cert_base_screen';
  @override
  _CertBaseScreenState createState() => _CertBaseScreenState();
}

class _CertBaseScreenState extends State<CertBaseScreen> {
  var index = 0;
  int selectedIndex = 0;
  bool icondEnable;
  bool goNext = false;
  bool goPrevious = false;
  final ScrollController _scrollController = ScrollController();

  void next() {
    setState(() {
      goNext = true;
      selectedIndex++;
    });
  }

  _scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<String> pageTitle = ['소득', '저축', '투자', '기타'];
  List<Widget> pageScreen = [];
  List<List<Color>> stepperColorSet = [
    [
      Color(0xFF4A4F56),
      Color(0xFFD1D1D6),
      Color(0xFFD1D1D6),
      Color(0xFFD1D1D6),
    ],
    [
      Color(0xFFD1D1D6),
      Color(0xFF4A4F56),
      Color(0xFFD1D1D6),
      Color(0xFFD1D1D6),
    ],
    [
      Color(0xFFD1D1D6),
      Color(0xFFD1D1D6),
      Color(0xFF4A4F56),
      Color(0xFFD1D1D6),
    ],
    [
      Color(0xFFD1D1D6),
      Color(0xFFD1D1D6),
      Color(0xFFD1D1D6),
      Color(0xFF4A4F56),
    ],
  ];
  @override
  void initState() {
    super.initState();
    print("123123123");
    pageScreen = [
      CertIncome(
        goNext: next,
        scrollToTop: _scrollToTop,
      ),
      CertSaving(
        goNext: next,
        scrollToTop: _scrollToTop,
      ),
      CertInvestment(
        goNext: next,
        scrollToTop: _scrollToTop,
      ),
      CertEtc(
        goNext: next,
        scrollToTop: _scrollToTop,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final CertPageArguments args = ModalRoute.of(context).settings.arguments;
    print('argsdgsdgs');
    print(args.page);

    if (selectedIndex < args.page) {
      selectedIndex = args.page;
      // for (var i = 0; i < selectedIndex; i++) {
      //   Basestepper      }
    }

    // selectedIndex = args.page;
    return AppBase(
      needAppBar: true,
      title: pageTitle[selectedIndex],
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              children: [
                CustomIconStepper(
                  stepColor: Colors.white,
                  selectedIndex: selectedIndex,
                  activeStepBorderColor: Color(0xFFCD2A35),
                  activeStepBorderWidth: 1.0,
                  activeStepColor: Color(0xFFF4F4F4),
                  lineColor: Color(0xFFCD2A35),
                  lineLength: 40,
                  scrollingDisabled: true,
                  goNext: goNext,
                  goPrevious: goPrevious,
                  steppingEnabled: true,
                  icons: [
                    Icon(
                      Icons.home,
                      color: stepperColorSet[selectedIndex][0],
                    ),
                    Icon(
                      Icons.home,
                      color: stepperColorSet[selectedIndex][1],
                    ),
                    Icon(
                      Icons.home,
                      color: stepperColorSet[selectedIndex][2],
                    ),
                    Icon(
                      Icons.home,
                      color: stepperColorSet[selectedIndex][3],
                    ),
                  ],
                ),
                pageScreen[selectedIndex],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
