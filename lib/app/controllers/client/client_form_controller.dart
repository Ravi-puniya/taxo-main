import 'package:facturadorpro/app/controllers/pos/pos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:cool_alert/cool_alert.dart';
import 'package:facturadorpro/shared/enums.dart';
import 'package:facturadorpro/shared/helpers.dart';
import 'package:facturadorpro/api/models/client_model.dart';
import 'package:facturadorpro/api/models/response_model.dart';
import 'package:facturadorpro/app/ui/widgets/custom_alert.dart';
import 'package:facturadorpro/api/providers/facturador_provider.dart';
import 'package:facturadorpro/api/models/init_params_client_model.dart';
import 'package:facturadorpro/api/models/response/sunat_person_model.dart';
import 'package:facturadorpro/api/models/request/client_request_model.dart';
import 'package:facturadorpro/app/controllers/client/client_controller.dart';
import 'package:facturadorpro/app/ui/pages/client_page/constants/panel_list.dart';
import 'package:facturadorpro/api/models/response/retrieve_client_response_model.dart';
import 'package:facturadorpro/api/models/response/response_client_errors_model.dart';

class ClientFormController extends GetxController {
  GetStorage box = GetStorage();
  FacturadorProvider provider = Get.put(FacturadorProvider());
  final posController = Get.put(PosController());
  final clientController = Get.find<ClientController>();

  FocusNode docNumberFocus = FocusNode();
  FocusNode nameFocus = FocusNode();

  TextEditingController docTypeCnt = TextEditingController();
  TextEditingController docNumberCnt = TextEditingController();
  TextEditingController nameCnt = TextEditingController();
  TextEditingController businessNameCnt = TextEditingController();
  TextEditingController daysLateCnt = TextEditingController();
  TextEditingController personTypeCnt = TextEditingController();
  TextEditingController internalCodeCnt = TextEditingController();
  TextEditingController barcodeCnt = TextEditingController();
  TextEditingController departmentCnt = TextEditingController();
  TextEditingController provinceCnt = TextEditingController();
  TextEditingController districtCnt = TextEditingController();
  TextEditingController addressCnt = TextEditingController();
  TextEditingController cellphoneCnt = TextEditingController();
  TextEditingController emailCnt = TextEditingController();
  TextEditingController contactNameCnt = TextEditingController();
  TextEditingController contactPhoneCnt = TextEditingController();
  TextEditingController websiteCnt = TextEditingController();
  TextEditingController observationCnt = TextEditingController();
  TextEditingController sellerCnt = TextEditingController();

  RxBool isSaving = false.obs;
  RxBool isLoadingParams = false.obs;
  RxBool isRetrieving = false.obs;
  RxBool isEnabledSunat = false.obs;
  RxBool isLoadingSunat = false.obs;

  RxString sunatAction = "".obs;
  RxInt maxLengthDocNumber = 25.obs;

  RxList<Location> locations = <Location>[].obs;
  RxList<LocationChild> selectedProvinces = <LocationChild>[].obs;
  RxList<ChildChild> selectedDistricts = <ChildChild>[].obs;

  RxList<Map<String, dynamic>> countries = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> departments = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> provinces = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> districts = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> documentTypes = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> personTypes = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> zones = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> sellers = <Map<String, dynamic>>[].obs;

  RxList<bool> expandedPanels = [true, false, false].obs;

  RxInt clientId = 0.obs;
  RxString documentTypeId = "".obs;
  RxString customerTypeId = "".obs;
  RxString departmentId = "".obs;
  RxString provinceId = "".obs;
  RxString districtId = "".obs;
  RxString sellerId = "".obs;
  RxBool isFromPos = false.obs;

  RxList<String> errorsName = <String>[].obs;
  RxList<String> errorsDocNumber = <String>[].obs;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      String arg = Get.arguments.toString();
      if (arg.startsWith("POS:")) {
        isFromPos.value = true;
        await onInitForm();
      }
      if (arg.startsWith("ID:")) {
        int id = int.parse(arg.split(":")[1]);
        await onInitForm(id: id);
      }
    } else {
      await onInitForm();
    }
    super.onInit();
  }

  void onExpandedPanel({required int index, required bool isExpanded}) {
    for (int i = 0; i < panelList.length; i++) {
      if (index == i) {
        expandedPanels[index] = !isExpanded;
      } else {
        expandedPanels[i] = false;
      }
    }
    update();
  }

  void resetErrorNames(_) => errorsName.value = [];
  void resetErrorNumber(_) => errorsDocNumber.value = [];

  void resetValues() {
    clientId.value = 0;
    documentTypeId.value = "";
    customerTypeId.value = "";
    departmentId.value = "";
    provinceId.value = "";
    districtId.value = "";
    sellerId.value = "";
    errorsName.value = [];
    errorsDocNumber.value = [];
    locations.value = [];
    selectedProvinces.value = [];
    selectedDistricts.value = [];
    docNumberCnt.clear();
    nameCnt.clear();
    businessNameCnt.clear();
    daysLateCnt.clear();
    internalCodeCnt.clear();
    barcodeCnt.clear();
    departmentCnt.clear();
    provinceCnt.clear();
    districtCnt.clear();
    addressCnt.clear();
    cellphoneCnt.clear();
    emailCnt.clear();
    contactNameCnt.clear();
    contactPhoneCnt.clear();
    websiteCnt.clear();
    observationCnt.clear();
  }

  void onChangedDepartment(String option) {
    departmentId.value = option;
    Location location = locations.firstWhere((e) => e.value == option);
    List<LocationChild> provincesOfDepartment = location.children;
    List<Map<String, dynamic>> _provinces = <Map<String, dynamic>>[];
    for (LocationChild element in provincesOfDepartment) {
      Map<String, dynamic> _province = {
        "value": element.value,
        "label": element.label,
      };
      _provinces.add(_province);
    }
    provinces.value = _provinces.toList();
    selectedProvinces.value = provincesOfDepartment;
    if (provinceId.isNotEmpty) {
      provinceId = "".obs;
      provinceCnt.text = "";
    }
    if (districtId.isNotEmpty) {
      districtId = "".obs;
      districts.value = [];
      selectedDistricts.value = [];
      districtCnt.text = "";
    }
    update();
  }

  void onChangedProvince(String option) {
    provinceId.value = option;
    List<ChildChild> districtsOfProvince = selectedProvinces.firstWhere((e) {
      return e.value == option;
    }).children;
    List<Map<String, dynamic>> _districts = <Map<String, dynamic>>[];
    for (ChildChild element in districtsOfProvince) {
      Map<String, dynamic> _district = {
        "value": element.value,
        "label": element.label,
      };
      _districts.add(_district);
    }
    districts.value = _districts.toList();
    selectedDistricts.value = districtsOfProvince;
    if (districtId.isNotEmpty) {
      districtId = "".obs;
      districtCnt.text = "";
    }
    update();
  }

  void onChangeSelect({required String option, required SelectTypes type}) {
    switch (type) {
      case SelectTypes.DOCUMENT_TYPE:
        documentTypeId.value = option;
        if (["6", "1"].contains(option)) {
          isEnabledSunat.value = true;
          if (option == "6") {
            maxLengthDocNumber.value = 11;
            sunatAction.value = "ruc";
          }
          if (option == "1") {
            maxLengthDocNumber.value = 8;
            sunatAction.value = "dni";
          }
        } else {
          isEnabledSunat.value = false;
          sunatAction.value = "";
        }
        docNumberCnt.text = "";
        nameCnt.text = "";
        docNumberFocus.requestFocus();
        break;
      case SelectTypes.CUSTOMER_TYPE:
        customerTypeId.value = option;
        break;
      case SelectTypes.DISTRICT:
        districtId.value = option;
        break;
      case SelectTypes.SELLER:
        sellerId.value = option;
        break;
      default:
        break;
    }
  }

  Future<void> onInitForm({int? id}) async {
    try {
      isLoadingParams.value = true;
      final Response res = await provider.initParamsClient();
      if (res.statusCode == 200) {
        InitParamsClientModel result = initParamsClientModelFromJson(
          res.bodyString!,
        );
        List<Map<String, dynamic>> _countries = <Map<String, dynamic>>[];
        List<Map<String, dynamic>> _departments = <Map<String, dynamic>>[].obs;
        List<Map<String, dynamic>> _docTypes = <Map<String, dynamic>>[].obs;
        List<Map<String, dynamic>> _persTypes = <Map<String, dynamic>>[].obs;
        List<Map<String, dynamic>> _zones = <Map<String, dynamic>>[].obs;
        List<Map<String, dynamic>> _sellers = <Map<String, dynamic>>[].obs;

        for (var element in result.countries) {
          Map<String, dynamic> country = {
            "value": element.id,
            "label": element.description,
          };
          _countries.add(country);
        }

        for (var element in result.departments) {
          Map<String, dynamic> department = {
            "value": element.id,
            "label": element.description,
          };
          _departments.add(department);
        }

        for (var element in result.identityDocumentTypes) {
          Map<String, dynamic> docType = {
            "value": element.id.toString(),
            "label": element.description,
          };
          _docTypes.add(docType);
        }

        for (var element in result.personTypes) {
          Map<String, dynamic> personType = {
            "value": element.id.toString(),
            "label": element.description,
          };
          _persTypes.add(personType);
        }

        for (var element in result.zones) {
          Map<String, dynamic> zone = {
            "value": element.id.toString(),
            "label": element.name,
          };
          _zones.add(zone);
        }

        for (var element in result.sellers) {
          Map<String, dynamic> seller = {
            "value": element.id.toString(),
            "label": element.name,
          };
          _sellers.add(seller);
        }

        countries.value = _countries.toList();
        departments.value = _departments.toList();
        documentTypes.value = _docTypes.toList();
        personTypes.value = _persTypes.toList();
        zones.value = _zones.toList();
        sellers.value = _sellers.toList();

        locations.addAll(result.locations);
        if (id != null) await _retrieveClientInfo(id: id);

        update();
      }
    } catch (error, s) {
      print(error);
      print(s);
      displayErrorMessage();
    } finally {
      isLoadingParams.value = false;
    }
  }

  Future<void> _retrieveClientInfo({required int id}) async {
    try {
      isRetrieving.value = true;
      clientId.value = id;
      final Response res = await provider.retrieveClient(id: id);
      if (res.statusCode == 200) {
        RetrieveClientResponseModel result =
            retrieveClientResponseModelFromJson(res.bodyString!);
        if (result.data != null) {
          ClientData info = result.data!;
          docTypeCnt.text = info.identityDocumentTypeId!;
          documentTypeId.value = info.identityDocumentTypeId!;
          docNumberCnt.text = info.number;
          nameCnt.text = info.name;
          if (info.tradeName != null) {
            businessNameCnt.text = info.tradeName!;
          }
          if (info.creditDays != null) {
            daysLateCnt.text = info.creditDays.toString();
          }
          if (info.personTypeId != null) {
            customerTypeId.value = info.personTypeId.toString();
            personTypeCnt.text = info.personTypeId.toString();
          }
          if (info.internalCode != null) {
            internalCodeCnt.text = info.internalCode!;
          }
          if (info.barcode != null) {
            barcodeCnt.text = info.barcode!;
          }
          if (info.department != null) {
            departmentCnt.text = info.department!.id;
            onChangedDepartment(info.department!.id);
          }
          if (info.province != null) {
            provinceCnt.text = info.province!.id;
            onChangedProvince(info.province!.id);
          }
          if (info.district != null) {
            districtCnt.text = info.district!.id;
            onChangeSelect(
              option: info.district!.id,
              type: SelectTypes.DISTRICT,
            );
          }
          if (info.address != null) {
            addressCnt.text = info.address!;
          }
          if (info.telephone != null) {
            cellphoneCnt.text = info.telephone!;
          }
          if (info.email != null) {
            emailCnt.text = info.email!;
          }
          if (info.contact != null) {
            if (info.contact!.fullName != null) {
              contactNameCnt.text = info.contact!.fullName!;
            }
            if (info.contact!.phone != null) {
              contactPhoneCnt.text = info.contact!.phone!;
            }
          }
          if (info.website != null) {
            websiteCnt.text = info.website!;
          }
          if (info.observation != null) {
            observationCnt.text = info.observation!;
          }
          if (info.sellerId != null) {
            sellerId.value = info.sellerId.toString();
            sellerCnt.text = info.sellerId.toString();
          }
        }
        update();
      }
    } catch (error) {
      print(error);
      displayErrorMessage();
    } finally {
      isRetrieving.value = false;
    }
  }

  Future<void> onSaveClient(BuildContext context) async {
    bool isEditing = clientId.value != 0;
    try {
      isSaving.value = true;
      Navigator.pop(context);
      customAlert(
        context: context,
        type: CoolAlertType.loading,
        message: "Guardando información....",
      );
      ClientRequestModel client = ClientRequestModel(
        identityDocumentTypeId: documentTypeId.value,
        number: docNumberCnt.text,
        name: nameCnt.text,
        tradeName: businessNameCnt.text,
        creditDays:
            daysLateCnt.text.isEmpty ? null : int.parse(daysLateCnt.text),
        personTypeId: customerTypeId.value.isEmpty
            ? null
            : int.parse(customerTypeId.value),
        internalCode:
            internalCodeCnt.text.isEmpty ? null : internalCodeCnt.text,
        barcode: barcodeCnt.text.isEmpty ? null : barcodeCnt.text,
        departmentId: departmentId.value.isEmpty ? null : departmentId.value,
        provinceId: provinceId.value.isEmpty ? null : provinceId.value,
        districtId: districtId.value.isEmpty ? null : districtId.value,
        address: addressCnt.text.isEmpty ? null : addressCnt.text,
        telephone: cellphoneCnt.text.isEmpty ? null : cellphoneCnt.text,
        email: emailCnt.text.isEmpty ? null : emailCnt.text,
        contact: Contact(
          fullName: contactNameCnt.text.isEmpty ? null : contactNameCnt.text,
          phone: contactPhoneCnt.text.isEmpty ? null : contactPhoneCnt.text,
        ),
        website: websiteCnt.text.isEmpty ? null : websiteCnt.text,
        observation: observationCnt.text.isEmpty ? null : observationCnt.text,
        sellerId: sellerId.value.isEmpty ? null : int.parse(sellerId.value),
      );
      if (isEditing) client.id = clientId.value;
      final Response res = await provider.registerClient(client);
      Navigator.pop(context);
      if (res.statusCode == 422) {
        ResponseClientErrorsModel response = responseClientErrorsModelFromJson(
          res.bodyString!,
        );
        print(res.bodyString!);
        List<String> _tmpErrorsName = <String>[];
        List<String> _tmpErrorsNumber = <String>[];
        if (response.message.name != null) {
          response.message.name!.map((e) => _tmpErrorsName.add(e)).toList();
        }
        if (response.message.number != null) {
          response.message.number!.map((e) => _tmpErrorsNumber.add(e)).toList();
        }
        errorsName.value = _tmpErrorsName;
        errorsDocNumber.value = _tmpErrorsNumber;
        update();
        customAlert(
          context: context,
          type: CoolAlertType.warning,
          title: "¡Advertencia!",
          message: "No se ha podido guardar debido a las restricciones.",
        );
      }
      print(res.statusCode);
      if (res.statusCode == 200) {
        ResponseModel response = responseModelFromJson(res.bodyString!);
        if (response.success == true) {
          if (!isEditing) resetValues();
          if (isFromPos.value) {
            await posController.reloadPosClients();
          } else {
            await clientController.filterClients(useLoader: false);
          }
          customAlert(
            context: context,
            type: CoolAlertType.success,
            title: "¡Perfecto!",
            message: response.message,
            onOk: () {
              if (isEditing) {
                clientId.value = 0;
                Navigator.of(context).pop();
                resetValues();
                Get.back();
              }
              if (isFromPos.value) {
                Navigator.of(context).pop();
                resetValues();
                Get.back();
              }
            },
          );
        } else {
          customAlert(
            context: context,
            type: CoolAlertType.error,
            title: "¡Error!",
            message: response.message,
          );
        }
      }
    } catch (error) {
      print(error);
      Navigator.pop(context);
      displayErrorMessage();
    } finally {
      isSaving.value = false;
    }
  }
  Future<void> onRequestSunatInfo(BuildContext context) async {
    try {
      isLoadingSunat.value = false;
      customAlert(
        context: context,
        message: "Consultando...",
        type: CoolAlertType.loading,
      );
      final Response res = await provider.fetchSunatPerson(
        action: sunatAction.value,
        number: docNumberCnt.text,
      );
      if (res.statusCode == 200) {
        SunatPersonModel result = sunatPersonModelFromJson(res.bodyString!);
        Navigator.pop(context);
        if (result.success == true) {
          DataSunat info = result.data!;
          nameCnt.text = info.name;
          nameFocus.requestFocus();
          if (info.tradeName != null) {
            businessNameCnt.text = info.tradeName!;
          }
          if (info.departmentId != null) {
            departmentCnt.text = info.departmentId!;
            onChangedDepartment(info.departmentId!);
            provinceCnt.text = info.provinceId!;
            onChangedProvince(info.provinceId!);
            districtCnt.text = info.districtId!;
            onChangeSelect(
              option: info.districtId!,
              type: SelectTypes.DISTRICT,
            );
          }
          if (info.address != null) addressCnt.text = info.address!;
        } else {
          displayWarningMessage(message: result.message!);
        }
      }
    } catch (error) {
      displayErrorMessage();
    } finally {
      isLoadingSunat.value = false;
    }
  }




}
