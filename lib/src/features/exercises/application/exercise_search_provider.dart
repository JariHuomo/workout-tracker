import 'package:flutter_riverpod/flutter_riverpod.dart';

final exerciseSearchQueryProvider =
    StateProvider.autoDispose<String>((_) => '');
