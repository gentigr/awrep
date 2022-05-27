Creating a class or enum, do not try to adjust provided value within the
constructor, instead verify it on conformance to the specified rules and 
do not continue instance creation if conformance is not passed.
+:
  -> less source code
  -> cleaner source code
  -> constant constructors
-:
  -> less user-friendly
  -> forces complying with specified format