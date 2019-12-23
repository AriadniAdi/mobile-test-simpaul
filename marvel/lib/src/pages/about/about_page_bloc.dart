import 'package:marvel/src/pages/about/about_page_view_model.dart';
import 'package:marvel/src/version.dart';

class AboutPageBloc {
  AboutPageViewModel get viewModel => AboutPageViewModel(
        version: packageVersion,
        developer: 'Ariadni Chioquetta',
      );
}
