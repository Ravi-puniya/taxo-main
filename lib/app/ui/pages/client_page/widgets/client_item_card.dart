import 'package:facturadorpro/app/routes/app_routes.dart';
import 'package:facturadorpro/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

import 'package:facturadorpro/app/ui/widgets/sizing.dart';
import 'package:facturadorpro/api/models/client_model.dart';
import 'package:facturadorpro/app/ui/theme/colors/primary.dart';
import 'package:facturadorpro/app/controllers/client/client_controller.dart';

class ClientItemCard extends GetView<ClientController> {
  const ClientItemCard({
    Key? key,
    required this.client,
  }) : super(key: key);

  final ClientData client;

  @override
  Widget build(BuildContext context) {
    return SwipeableTile.swipeToTriggerCard(
      color: Colors.white,
      shadow: BoxShadow(
        blurRadius: 8,
        spreadRadius: 2,
        color: Colors.grey.shade200,
      ),
      borderRadius: 8,
      horizontalPadding: 0,
      verticalPadding: 6,
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) async {
        if (direction == SwipeDirection.startToEnd) {
          controller.onDeleteClient(client: client);
        }
        if (direction == SwipeDirection.endToStart) {
          Get.toNamed(
            Routes.ADD_CLIENT,
            arguments: "ID:${client.id}",
          );
        }
      },
      backgroundBuilder: (context, direction, progress) {
        if (direction == SwipeDirection.startToEnd) {
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                color: progress.value > 0.4
                    ? Colors.red.shade600
                    : Colors.red.shade100,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Transform.scale(
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.2,
                      )
                          .animate(
                            CurvedAnimation(
                              parent: progress,
                              curve: const Interval(
                                0.5,
                                1.0,
                                curve: Curves.linear,
                              ),
                            ),
                          )
                          .value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.remove_circle,
                            color: Colors.white,
                          ),
                          spaceW(8),
                          Text(
                            "ELIMINAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return AnimatedBuilder(
            animation: progress,
            builder: (context, child) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                color: progress.value > 0.4
                    ? Colors.blue.shade600
                    : Colors.blue.shade100,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 55.0),
                    child: Transform.scale(
                      scale: Tween<double>(
                        begin: 0.0,
                        end: 1.2,
                      )
                          .animate(
                            CurvedAnimation(
                              parent: progress,
                              curve: const Interval(
                                0.5,
                                1.0,
                                curve: Curves.linear,
                              ),
                            ),
                          )
                          .value,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Colors.white,
                          ),
                          spaceW(8),
                          Text(
                            "EDITAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      key: UniqueKey(),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
            Get.bottomSheet(
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 5.0,
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: const EdgeInsets.only(bottom: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                color: Colors.black.withOpacity(0.20),
                              ),
                            ),
                          ),
                          Text(
                            client.name.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                margin: const EdgeInsets.only(top: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.20),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "${client.documentType} ${client.number}",
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                margin: const EdgeInsets.only(
                                  top: 5.0,
                                  left: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: (client.documentType.startsWith('DNI')
                                          ? Colors.blue
                                          : Colors.purple)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "PERSONA ${client.documentType.startsWith('DNI') ? "NATURAL" : "JURÍDICA"}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: client.documentType.startsWith('DNI')
                                        ? Colors.blue
                                        : Colors.purple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    Colors.indigo.withOpacity(0.15),
                                foregroundColor: Colors.indigo.shade600,
                                child: const Icon(Icons.phone, size: 16.0),
                              ),
                              title: const Text(
                                "NRO. CONTACTO",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                client.telephone ?? '- Sin información -',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              dense: true,
                            ),
                            const Divider(),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal.withOpacity(0.15),
                                foregroundColor: Colors.teal.shade600,
                                child: const Icon(
                                  Icons.email,
                                  size: 16.0,
                                ),
                              ),
                              title: const Text(
                                "CORREO ELECTRÓNICO",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                client.email ?? '- Sin información -',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              dense: true,
                            ),
                            if (client.address != null &&
                                client.district != null)
                              const Divider(),
                            if (client.address != null &&
                                client.district != null)
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      Colors.pink.withOpacity(0.15),
                                  foregroundColor: Colors.pink.shade600,
                                  child: const Icon(
                                    Icons.map,
                                    size: 16.0,
                                  ),
                                ),
                                title: Text(
                                  client.address ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Text(
                                  client.district != null
                                      ? "${client.district!.description}, ${client.province!.description} - ${client.department!.description}"
                                      : '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                dense: true,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isScrollControlled: true,
              ignoreSafeArea: false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              backgroundColor: Colors.white,
            );
          },
          highlightColor: Colors.white,
          splashColor: primaryColor.shade100,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: (client.documentType.startsWith('DNI')
                            ? Colors.blue
                            : Colors.purple)
                        .withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    client.documentType.startsWith('DNI')
                        ? Icons.account_circle
                        : Icons.business,
                    size: 18.0,
                    color: client.documentType.startsWith('DNI')
                        ? Colors.blue
                        : Colors.purple,
                  ),
                ),
                spaceW(12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                      spaceH(4),
                      Column(
                        children: [
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.perm_identity, size: 12.0),
                              const SizedBox(width: 4.0),
                              Text(
                                "${client.identityDocumentTypeId == NODOC ? "Sin Doc." : client.documentType} ${client.number}",
                              ),
                              const SizedBox(width: 12.0),
                              if (client.telephone != null) Spacer(),
                              if (client.telephone != null)
                                const Icon(Icons.phone, size: 12.0),
                              if (client.telephone != null)
                                const SizedBox(width: 4.0),
                              if (client.telephone != null)
                                Text(client.telephone ?? "-"),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined, size: 12.0),
                              const SizedBox(width: 4.0),
                              Text(
                                client.email ?? " - Correo no registrado -",
                                style: TextStyle(
                                  color: client.email == null
                                      ? Colors.grey.shade400
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
