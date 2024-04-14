import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/app/controllers/get_started_controller.dart';

class GetstartPage extends GetView<GetStartedController> {
  const GetstartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Text(
                //   'Haga que su negocio sea fácil y profesional',
                 //  style: TextStyle(
                //     color: Color(0xff212529),
                //     fontSize: 28,
                //     fontWeight: FontWeight.w900,
                //   ),
               //  ),
                const SizedBox(height: 1),
               // const Text(
               //   'Facturador Pro es la mejor opción para cubrir las necesidades comerciales de su negocio.',
               //    style: TextStyle(
                //     color: Color(0xff545E64),
                //     fontSize: 14,
                 //    fontWeight: FontWeight.w400,
                //   ),
               //  ),
                const SizedBox(
                  height: 1,
                ),
                Center(
                  child: Image.asset(
                    'assets/getstart.png',
                    height: screenSize.height * 0.35,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () => controller.navigatorValidateDomain(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CONTINUAR',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                        ),
                        spaceW(10),
                        Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
