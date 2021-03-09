import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/api/Api.dart';

import 'companyInnState.dart';

class CompanyInnCubit extends Cubit<CompanyInnState> {
  CompanyInnCubit(this.apiService) : super(InitialCompanyInnState());

  ApiService apiService;

  void initial(String key) async {
    var companies;
    if (key.length == 0) companies = await apiService.getCompanyList("0");
    else companies = await apiService.getCompanyList(key);
    emit(LoadingCompanyInnState());
    emit(LoadedCompanyInnState(companies.companyList));
  }
}