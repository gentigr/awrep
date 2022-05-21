The library implementation follows the technique of writing Dart code:
[AVOID storing what you can calculate.](https://dart.dev/guides/language/effective-dart/usage#avoid-storing-what-you-can-calculate)
As a result it may have additional performance penalty in comparison to the
libraries that parses provided METAR/SPECI report completely during object
construction phase.