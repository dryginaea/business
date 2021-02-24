import 'package:equatable/equatable.dart';
import 'package:isbusiness/data/company/company.dart';

abstract class CompanyInnState extends Equatable {}

class InitialCompanyInnState extends CompanyInnState {
  @override
  List<Object> get props => [];
}

class LoadingCompanyInnState extends CompanyInnState {
  @override
  List<Object> get props => [];
}

class LoadedCompanyInnState extends CompanyInnState {
  List<Company> companyList;

  LoadedCompanyInnState(this.companyList);

  @override
  List<Object> get props => [companyList];
}