From Dart guidelines the recommendation is to use
[relative paths](https://dart.dev/guides/language/effective-dart/usage#do-use-relative-paths-when-importing-libraries-within-your-own-packages-lib-directory).
However, it is just a recommendation based on later said:

>There is no profound reason to prefer the former — it’s just shorter,
>and we want to be consistent.

- since the code is read more than is written, the absolute path seems to be
  easier to read because there is little to no hassle on understanding which
  exact file is imported in case if file names are the same;
  more details can be found [here](https://stackoverflow.com/a/61604885)

- having both pure files and relative paths from another directory (import path
  with preceding dots) may not look very attractive (personal preference)

- most IDE-s automatically are adding absolute paths, may become inconvenient
  to re-adjust all the time

- look inconsistent in comparison to tests which have to use absolute paths

- using relative paths one has to comply with a set of rules that will cause
  the delay during the development to think about, better to avoid if it can
  be avoided