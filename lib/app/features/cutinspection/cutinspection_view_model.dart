import 'package:flutter/material.dart';
import 'package:qapp/app/base/base_view_model.dart';
import 'package:qapp/app/base/di.dart';
import 'package:qapp/app/data/network/dto/GetAllActiveFactoryModel.dart';
import 'package:qapp/app/data/network/dto/GetDsListModel.dart';
import 'package:qapp/app/data/network/dto/GetOrderRegWithbuyerModel.dart';
import 'package:qapp/app/data/network/dto/GetProdSamCutInspectionByIdNew.dart';
import 'package:qapp/app/data/network/dto/GetProdSamCutInspectionByparams.dart';
import 'package:qapp/app/data/network/dto/GetProductType.dart';
import 'package:qapp/app/data/network/dto/SaveCutInspectionModel.dart';
import 'package:qapp/app/features/cutinspection/cutinspection_use_case.dart';
import 'package:qapp/app/utils/code_snippet.dart';
import '../../data/local/shared_prefs_helper.dart';
import '../../data/network/dto/GetAllGarPartDataModel.dart';
import '../../data/network/dto/GetBuyerFromOrderRegModel.dart';
import '../../data/network/dto/saveCutInspectionResponseModel.dart';
import '../../res/constants.dart';

class CutInspectionViewModel extends BaseViewModel {
  final CutInspectionUserCase _useCase =
      AppManager.instance.cutinspectionUseCase();
  saveCutInspectionModel savecutInspection = saveCutInspectionModel();
  savecutInspectionResponseModel savecutInspectionResponse =
      savecutInspectionResponseModel();
  GetProdSamCutInspectionByIdNew getID = GetProdSamCutInspectionByIdNew();
  GetAllGarPartDataModel partData = GetAllGarPartDataModel();
  GetProductType productdata = GetProductType();
  DateTime dateToday = DateTime.now();
  DateTime time = DateTime.timestamp();
  GetDsListModel getDsData = GetDsListModel();
  final majorparts = TextEditingController();
  final marker = TextEditingController();
  final ncrper = TextEditingController();
  final cutno = TextEditingController();
  final totalpanels = TextEditingController();
  final defectivepanels = TextEditingController();
  void majorpartsonChange(context, int majorParts) {
    savecutInspection.majorParts = majorParts;
    notifyListeners();
  }

  bool styleInfoExpanded = false;
  void setStyleInfoExpanded() {
    styleInfoExpanded = !styleInfoExpanded;
    notifyListeners();
  }

  void markeronChange(context, int marker) {
    savecutInspection.marker = marker;
    notifyListeners();
  }

  void ncronChange(context, int ncr) {
    savecutInspection.ncrPer = ncr;
    notifyListeners();
  }

  void cutonChange(context, int cut) {
    // savecutInspection.ncrPer = cut;
    notifyListeners();
  }

  void totalonChange(context, int total) {
    savecutInspection.totalInsPanels = total;
    notifyListeners();
  }

  void defectonChange(context, int defect) {
    savecutInspection.defectivePanels = defect;
    notifyListeners();
  }

  void onGetInit(
    BuildContext context,
  ) async {
    initUpdateCutData();
    GetAllActiveFactoryAPI(context);
    getBuyerFromOrderReg(context);
    // getproducttype(context, savecutInspection.orderNo);
    // getDsList(context, savecutInspection.orderNo);

    dismissProgress();
  }

  getPart(context, productType) {
    print(partData.data);
    productdata.data = productType;
    partData = GetAllGarPartDataModel();
    notifyListeners();
    _useCase.getPartData(productType.toString(), (data) {
      partData = data;

      List<GarPartData> listOf = [];
      var newList = partData.data ?? [];
      for (int i = 0; i < newList.length; i++) {
        if (newList[i].active == "Y") {
          listOf.add(newList[i]);
        }
      }
      partData.data = listOf;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
      showErrorAlert('Invalid ProductType');
    });
  }

  // getproducttype(context, orderNo) {
  //   savecutInspection.orderNo = orderNo;
  //   productdata = GetProductType();

  //   notifyListeners();
  //   _useCase.getProductType(orderNo.toString(), (data) {
  //     print(data);
  //     productdata.data = data;
  //     getPart(context, data);
  //     notifyListeners();
  //     dismissProgress();
  //   }, (errorMessage) {
  //     dismissProgress();
  //     showErrorAlert('Something went wrong');
  //   });
  // }

  void sleeveValueOnchange(context, String sleeve) {
    savecutInspection.partcode = sleeve.toString();

    notifyListeners();
  }

  void fitOnchange(BuildContext context, String fit) {
    savecutInspection.fit = fit;
    getsamCut(
        context,
        savecutInspection.unitCode.toString(),
        savecutInspection.transDate.toString(),
        savecutInspection.buyerCode.toString(),
        savecutInspection.orderNo.toString(),
        savecutInspection.color.toString(),
        savecutInspection.fit.toString());

    notifyListeners();
  }

  void sizeOnchange(String size) {
    savecutInspection.size = size;
    notifyListeners();
  }

  void colorValueOnchange(BuildContext context, String color) {
    savecutInspection.color = color;
    notifyListeners();
  }

  void unitCodeOnchange(BuildContext context, String ucode) {
    savecutInspection.unitCode = ucode;
    print(savecutInspection.unitCode);

    notifyListeners();
  }

  GetProdSamCutInspectionByparams getProdSamCutInspectionByparams =
      GetProdSamCutInspectionByparams();
  getsamCut(
    context,
    String unitcode,
    String date,
    String buyercode,
    String orderno,
    String color,
    String fit,
  ) {
    notifyListeners();
    getProdSamCutInspectionByparams = GetProdSamCutInspectionByparams();
    notifyListeners();

    _useCase.getsamCutting(unitcode, date, buyercode, orderno, color, fit,
        (data) {
      getProdSamCutInspectionByparams = data;
      majorparts.text =
          getProdSamCutInspectionByparams.data![0].majorParts.toString();
      marker.text = getProdSamCutInspectionByparams.data![0].marker.toString();
      ncrper.text = getProdSamCutInspectionByparams.data![0].ncrPer.toString();
      if ((getProdSamCutInspectionByparams.data ?? []).isNotEmpty) {
        /* getCutById(
                    getProdSamCutInspectionByparams.data?[0].id ?? 0,
                    'ProdSamCutInspection/GetProdSamCutInspectionByIdNew/',
                    context);*/
      } else {
        initUpdateCutt();
      }
      dismissProgress();
      notifyListeners();
    }, (errorMessage) {
      print(errorMessage);
      initUpdateCutt();
      dismissProgress();
    });
  }

  GetBuyerFromOrderRegModel getBuyerFromOrderRegDetail =
      GetBuyerFromOrderRegModel();
  GetOrderRegWithbuyerModel getOrderRegWithbuyerDetail =
      GetOrderRegWithbuyerModel();
  getBuyerFromOrderReg(
    context,
  ) {
    getBuyerFromOrderRegDetail = GetBuyerFromOrderRegModel();
    savecutInspection.buyerCode = null;
    notifyListeners();
    _useCase.getBuyerFromOrderRegData((data) {
      getBuyerFromOrderRegDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  getOrderRegWithbuyer(
    String buyerdivcode,
    context,
  ) {
    getOrderRegWithbuyerDetail = GetOrderRegWithbuyerModel();
    savecutInspection.buyerCode = buyerdivcode;
    savecutInspection.orderNo = null;
    savecutInspection.orderNoString = null;
    savecutInspection.styleNo = null;
    notifyListeners();
    _useCase.getOrderRegWithbuyerData(buyerdivcode, (data) {
      getOrderRegWithbuyerDetail = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
    });
  }

  GetAllActiveFactoryModel GetAllActiveFactoryData = GetAllActiveFactoryModel();
  GetAllActiveFactoryAPI(context) async {
    String locationcode =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    GetAllActiveFactoryData = GetAllActiveFactoryModel();
    notifyListeners();
    _useCase.GetAllActiveFactoryAPI(locationcode, (data) {
      GetAllActiveFactoryData = data;
      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      showErrorAlert(errorMessage);
      dismissProgress();
    });
  }

  getDsList(context, orderNo) {
    savecutInspection.orderNo = orderNo;
    getDsData = GetDsListModel();
    notifyListeners();
    _useCase.getDsLists(orderNo.toString(), (data) {
      print(orderNo);
      getDsData = data;

      notifyListeners();
      dismissProgress();
    }, (errorMessage) {
      dismissProgress();
      showErrorAlert('Something went wrong');
    });
  }

  void showErrorAlert(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  void showErrorAlert2(String message) {
    CodeSnippet.instance.showSuccessMsg(message);
  }

  getCutById(
    int id,
    String endpoint,
    context,
  ) {
    getID = GetProdSamCutInspectionByIdNew();
    notifyListeners();
    _useCase.getsamCuttID(id, endpoint, (data) {
      getID = data;
      majorparts.text = getID.data!.majorParts.toString();
      marker.text = getID.data!.marker.toString();
      ncrper.text = getID.data!.ncrPer.toString();
      totalpanels.text = getID.data!.totalInsPanels.toString();
      cutno.text = getID.data!.cutNo.toString();
      defectivepanels.text = getID.data!.defectivePanels.toString();
      cutt();
      //cutt();
      notifyListeners();
    }, (errorMessage) {
      initUpdateCutt();
      dismissProgress();
    });
  }

  showDate(BuildContext context, bool isStart) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xffF06434), // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xffF06434), // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (isStart) {
        savecutInspection.transDate =
            value.toString().characters.take(10).toString();
      } else {}
      notifyListeners();
      if (value == null) {
        if (isStart) {
          savecutInspection.transDate = '';
        } else {}
      }
      return null;
    });
  }

  postSaveCutInspection(
    context,
    Null Function() param1,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showProgress(context);
    savecutInspectionResponse = savecutInspectionResponseModel();

    notifyListeners();
    String currentDate = dateToday.toString().substring(0, 10);
    dynamic data = [savecutInspection];
    String userN =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    data = [savecutInspection];
    [
      savecutInspection.createdDate = currentDate,
      savecutInspection.createdBy = userN,
      savecutInspection.modifiedDate = currentDate,
      savecutInspection.modifiedBy = userN,
      savecutInspection.isActive = true,
      savecutInspection.id = 0,
      savecutInspection.entityID = "ent",
      savecutInspection.partcode = "Null",
      savecutInspection.size = "Null",
      // savecutInspection.buyerCode = "BRFMT",
      // savecutInspection.styleNo = "801167-582000 SPR22",
      // savecutInspection.orderNo = 30471,
      // savecutInspection.color = "MIDNIGHT FLORAL TLE WM",
      // savecutInspection.fit = "REG",
      // savecutInspection.majorParts = 3,
      // savecutInspection.marker = 3,
      // savecutInspection.ncrPer = 3,
      // savecutInspection.totalInsPanels = 10,
      // savecutInspection.defectivePanels = 10,
      savecutInspection.active = "Y",
      savecutInspection.hostName = "string"
    ];
    _useCase.postSaveCutInspection(
        data, 'ProdSamCutInspection/SaveProdSamCutInspectionList', (data) {
      savecutInspectionResponse = data;
      print(savecutInspectionResponse.data?[0].id);
      getCutById((savecutInspectionResponse.data ?? [])[0].id ?? 0,
          'ProdSamCutInspection/GetProdSamCutInspectionByIdNew/', context);

      showErrorAlert('Saved');

      print(data);

      dismissProgress();
      notifyListeners();
      // cleardata();
    }, (errorMessage) {
      print(errorMessage);
      dismissProgress();
    });
  }

  void initUpdateCutt() async {
    String entityLocationCode =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    String userDisplayName =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    getID = GetProdSamCutInspectionByIdNew();
    savecutInspection.createdDate = currentDate;
    savecutInspection.createdBy = userDisplayName;
    savecutInspection.modifiedDate = currentDate;
    savecutInspection.modifiedBy = userDisplayName;
    savecutInspection.isActive = true;
    savecutInspection.id = 0;
    savecutInspection.entityID = "ent";
    savecutInspection.unitCode = unitCode;
    savecutInspection.transDate = currentDate;
    savecutInspection.buyerCode = "";
    savecutInspection.styleNo = "";
    savecutInspection.orderNo = 0;
    savecutInspection.color = "";
    savecutInspection.fit = "";
    savecutInspection.size = "";
    savecutInspection.majorParts = 0;
    savecutInspection.marker = 0;
    savecutInspection.ncrPer = 0;
    savecutInspection.partcode = "Null";
    savecutInspection.cutNo = 0;
    savecutInspection.totalInsPanels = 0;
    savecutInspection.defectivePanels = 0;
    savecutInspection.active = "Y";
    savecutInspection.hostName = "";
  }

  void getOrderRegWithbuyerOnchange(
      String styleNo, String orderNo, BuildContext context) async {
    savecutInspection.orderNo = int.parse(orderNo);
    String currentDate = dateToday.toString().substring(0, 10);
    savecutInspection.styleNo = styleNo.toString();
    // saveWashData.orderNoString = orderNo;
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    // getsamCut(unitCode, currentDate ,savecutInspection.buyerCode.toString(), savecutInspection.orderNo.toString(), savecutInspection.color.toString(), savecutInspection.fit.toString(), context);
  }

  void cutt() {
    savecutInspection.id = getID.data?.id ?? 0;
    savecutInspection.unitCode = getID.data?.unitCode ?? '';
    savecutInspection.marker = getID.data?.marker.toString() as int?;
    savecutInspection.majorParts = getID.data?.majorParts.toString() as int?;
    savecutInspection.cutNo = getID.data?.cutNo.toString() as int?;
    savecutInspection.totalInsPanels =
        getID.data?.totalInsPanels.toString() as int?;
    savecutInspection.defectivePanels =
        getID.data?.defectivePanels.toString() as int?;
  }

  void initUpdateCutData() async {
    String entityLocationCode =
        await SharedPreferenceHelper.getString(Constants.entityLocationCode);
    String userDisplayName =
        await SharedPreferenceHelper.getString(Constants.userDisplayName);
    String currentDate = dateToday.toString().substring(0, 10);
    String unitCode = await SharedPreferenceHelper.getString('unitCode');
    savecutInspection.createdDate = currentDate;
    savecutInspection.createdBy = userDisplayName;
    savecutInspection.modifiedDate = currentDate;
    savecutInspection.modifiedBy = userDisplayName;
    savecutInspection.isActive = true;
    savecutInspection.id = 0;
    savecutInspection.entityID = "ent";
    savecutInspection.unitCode = unitCode;
    savecutInspection.transDate = currentDate;
    savecutInspection.buyerCode = null;
    savecutInspection.styleNo = null;
    savecutInspection.orderNo = null;
    savecutInspection.color = null;
    savecutInspection.fit = null;
    savecutInspection.size = null;
    savecutInspection.majorParts = 0;
    savecutInspection.marker = 0;
    savecutInspection.ncrPer = 0;
    savecutInspection.partcode = "Null";
    savecutInspection.cutNo = 0;
    savecutInspection.totalInsPanels = 0;
    savecutInspection.defectivePanels = 0;
    savecutInspection.active = "Y";
    savecutInspection.hostName = "";
  }

  @override
  notifyListeners();
}
