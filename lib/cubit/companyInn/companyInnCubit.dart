import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isbusiness/api/Api.dart';
import 'package:isbusiness/data/company/company.dart';

import 'companyInnState.dart';

class CompanyInnCubit extends Cubit<CompanyInnState> {
  CompanyInnCubit(this.apiService) : super(InitialCompanyInnState());

  ApiService apiService;

  Future<List<Company>> initial(String key) async {
    var companies = await apiService.getCompanyList(key);
    emit(LoadingCompanyInnState());
    emit(LoadedCompanyInnState(companies.companyList));
  }
}