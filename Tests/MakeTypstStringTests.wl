(* ::Package:: *)

(* Make sure our package is loaded *)
Needs["TypstForm`"];

(* List of tests, updated to match Wolfram’s canonical ordering *)
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
    "(1 + x ^ 2)/(-1 + 2 * y)",
    TestID -> "Divide[…,…]"
  ],
  VerificationTest[
    MakeTypstString[
      (x^2 + 3 x)/(2 y - 1) + Sqrt[Sin[\[Theta]]] + E^(3 + \[Alpha])
    ],
    "e^(3 + alpha) + (3 * x + x ^ 2)/(-1 + 2 * y) + sqrt(sin(theta))",
    TestID -> "Combined example"
  ],
  VerificationTest[
    MakeTypstString[CustomHead[2, 5]],
    "CustomHead[2, 5]",
    TestID -> "Fallback"
  ],
  VerificationTest[
  MakeTypstString[{1, 2}],
  "vec(1,2)",
  TestID -> "Vec of two numbers"
],

VerificationTest[
  MakeTypstString[{{a, b}, {c, d}}],
  "mat(a,b;c,d)",
  TestID -> "Mat of 2×2 symbols"
],
VerificationTest[
  MakeTypstString[{x^2, Sin[\[Theta]]}],
  "vec(x ^ 2,sin(theta))",
  TestID -> "Vec with expressions"
],

VerificationTest[
  MakeTypstString[{{1, x + y}, {Sin[\[Alpha]], E^x}}],
  "mat(1,x + y;sin(alpha),e^(x))",
  TestID -> "Mat with mixed elements"
],
VerificationTest[
  MakeTypstString[x'[t]],
  "dv(x,t)",
  TestID -> "First‐derivative of x"
],

VerificationTest[
  MakeTypstString[Derivative[2][y][t]],
  "dv(y,t,deg:2)",
  TestID -> "Second‐derivative of y"
],

VerificationTest[
  MakeTypstString[{x'[t], Derivative[3][a][s]}],
  "vec(dv(x,t),dv(a,s,deg:3))",
  TestID -> "Vec of 1st and 3rd derivatives"
],


};

(* Run them and generate a report *)
TestReport[tests]
