import 'package:avatar_glow/avatar_glow.dart';
import 'package:binance_cl/shared/custom_text.dart';
import 'package:binance_cl/utils/colors.dart';
import 'package:binance_cl/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Trans;
import 'package:speed_test_dart/classes/classes.dart';
import 'package:speed_test_dart/speed_test_dart.dart';

class NetworkTest extends StatefulWidget {
  const NetworkTest({Key? key}) : super(key: key);

  @override
  State<NetworkTest> createState() => _NetworkTestState();
}

class _NetworkTestState extends State<NetworkTest> {
  SpeedTestDart tester = SpeedTestDart();
  List<Server> bestServersList = [];

  double downloadRate = 0;
  double uploadRate = 0;

  bool readyToTest = false;
  bool loadingDownload = false;
  bool loadingUpload = false;

  Future<void> setBestServers() async {
    final settings = await tester.getSettings();
    final servers = settings.servers;

    final bestServersListt = await tester.getBestServers(
      servers: servers,
    );

    if (mounted) {
      setState(() {
        bestServersList = bestServersListt;
        readyToTest = true;
      });
    }
  }

  Future<void> _testDownloadSpeed() async {
    setState(() {
      loadingDownload = true;
    });
    final downloadRatee =
        await tester.testDownloadSpeed(servers: bestServersList);
    setState(() {
      downloadRate = downloadRatee;
      loadingDownload = false;
    });
  }

  Future<void> _testUploadSpeed() async {
    setState(() {
      loadingUpload = true;
    });

    final uploadRatee = await tester.testUploadSpeed(servers: bestServersList);

    setState(() {
      uploadRate = uploadRatee;
      loadingUpload = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setBestServers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: LayoutBuilder(builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.03),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      color: kText2Color,
                    ),
                  ),
                  SizedBox(height: heightSize(30)),
                  const CText(
                    text: "Network Test",
                    color: kWhiteColor,
                    size: 30,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: heightSize(40)),
                  GestureDetector(
                    onTap: () {
                      _testDownloadSpeed();
                    },
                    child: const Align(
                      child: AvatarGlow(
                        glowColor: kPrimaryColor,
                        endRadius: 120.0,
                        duration: Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        repeatPauseDuration: Duration(milliseconds: 100),
                        child: CircleAvatar(
                          backgroundColor: kBlackColor,
                          radius: 70.0,
                          child: CText(
                            text: "GO",
                            fontWeight: FontWeight.w700,
                            size: 27,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heightSize(40)),
                  Row(
                    children: [
                      Container(
                        height: heightSize(40),
                        width: widthSize(40),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.purple),
                        ),
                        child: const Center(
                          child: Icon(
                            Feather.download,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      SizedBox(width: widthSize(20)),
                      const CText(
                        text: "DOWNLOAD",
                        color: kText2Color,
                        size: 20,
                      ),
                      SizedBox(width: widthSize(5)),
                      const CText(
                        text: "Mbps",
                        color: kText2Color,
                        size: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      const Spacer(),
                      CText(
                        text: downloadRate.toStringAsFixed(2),
                        color: kText2Color,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ));
  }
}
