(* ::Package:: *)

(* 1. Declare the package and its public symbols *)
BeginPackage["TypstForm`"]

MakeTypstString::usage =
  "MakeTypstString[expr] returns a Typst-compatible string for expr.";

Begin["`Private`"]

ClearAll[MakeTypstString];

MakeTypstString[n_Integer] := ToString[n];
MakeTypstString[n_Rational] := "(" <> ToString[Numerator[n]] <> ")/(" <> ToString[Denominator[n]] <> ")";
MakeTypstString[Pi] := "pi";
MakeTypstString[s_Symbol] /; StringLength[ToString[s]] == 1 := Module[
  {name = CharacterName[ToString[s], "TeXName"]},
  If[
    StringQ[name] && StringLength[name] > 0,
    ToLowerCase[name],
    ToString[s]
  ]
];
MakeTypstString[s_Symbol] := SymbolName[s];

MakeTypstString[Exp[x_]] := "e^(" <> MakeTypstString[x] <> ")";

unaryMap = {
  Sin -> "sin",
  Cos -> "cos",
  Tan -> "tan",
  Log -> "log",
  Sqrt -> "sqrt",
  Abs -> "abs",
  Exp -> "e"
};
Scan[
  Function[{rule},
    Module[{matHead = rule[[1]], typstName = rule[[2]]},
      If[matHead =!= Exp,
        MakeTypstString[matHead[x_]] := typstName <> "(" <> MakeTypstString[x] <> ")"
      ]
    ]
  ],
  unaryMap
];

MakeTypstString[p_Power] := Module[{b, e, sb, se},
  {b, e} = List @@ p;
  se = MakeTypstString[e];
  sb = MakeTypstString[b];
  sb = If[
    MatchQ[b, _Plus | _Times | _Divide | _Power],
    "(" <> sb <> ")",
    sb
  ];
  If[b === E,
    "e^(" <> se <> ")",
    sb <> " ^ " <> se
  ]
];

MakeTypstString[t_Times] :=
  StringRiffle[MakeTypstString /@ List @@ t, " * "];
MakeTypstString[a_Plus] :=
  StringRiffle[MakeTypstString /@ List @@ a, " + "];
MakeTypstString[Divide[a_, b_]] :=
  "(" <> MakeTypstString[a] <> ")/(" <> MakeTypstString[b] <> ")";
MakeTypstString[other_] := ToString[InputForm[other]];

End[]   (* closes `TypstForm`Private` *)
EndPackage[]
