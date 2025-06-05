(* ::Package:: *)

(* Make sure our package is loaded *)
Needs["TypstForm`"];

(* List of tests *)
tests = {
  VerificationTest[
    MakeTypstString[42],
    "42",
    TestID -> "Integer"
  ],
  VerificationTest[
    MakeTypstString[7/3],
    "(7)/(3)",
    TestID -> "Rational"
  ],
  VerificationTest[
    MakeTypstString[x],
    "x",
    TestID -> "Symbol x"
  ],
  VerificationTest[
    MakeTypstString[\[Theta]],
    "theta",
    TestID -> "Greek theta"
  ],
  VerificationTest[
    MakeTypstString[Sin[\[Alpha]]],
    "sin(alpha)",
    TestID -> "sin(alpha)"
  ],
  VerificationTest[
    MakeTypstString[Sqrt[Cos[\[Beta]]]],
    "sqrt(cos(beta))",
    TestID -> "sqrt(cos(beta))"
  ],
  VerificationTest[
    MakeTypstString[(a + b)^2],
    "(a + b) ^ 2",
    TestID -> "(a+b)^2"
  ],
  VerificationTest[
    MakeTypstString[E^(3 + \[Gamma])],
    "e^(3 + gamma)",
    TestID -> "E^(… + gamma)"
  ],
  VerificationTest[
    MakeTypstString[Exp[x^2]],
    "e^(x ^ 2)",
    TestID -> "Exp[x^2]"
  ],
  VerificationTest[
    MakeTypstString[3 x + 5 y],
    "3 * x + 5 * y",
    TestID -> "3x + 5y"
  ],
  VerificationTest[
    MakeTypstString[Divide[x^2 + 1, 2 y - 1]],
    "(x ^ 2 + 1)/(2 * y - 1)",
    TestID -> "Divide[…,…]"
  ],
  VerificationTest[
    MakeTypstString[
      (x^2 + 3 x)/(2 y - 1) + Sqrt[Sin[\[Theta]]] + E^(3 + \[Alpha])
    ],
    "(x ^ 2 + 3 * x)/(2 * y - 1) + sqrt(sin(theta)) + e^(3 + alpha)",
    TestID -> "Combined example"
  ],
  VerificationTest[
    MakeTypstString[CustomHead[2, 5]],
    "CustomHead[2, 5]",
    TestID -> "Fallback"
  ]
};

(* Run them and generate a report *)
TestReport[tests]
