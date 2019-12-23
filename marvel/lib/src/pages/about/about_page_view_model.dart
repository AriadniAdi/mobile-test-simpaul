import 'package:meta/meta.dart';

class AboutPageViewModel {
  const AboutPageViewModel({@required this.version, @required this.developer})
      : assert(version != null),
        assert(developer != null);
  final String version, developer;
}
