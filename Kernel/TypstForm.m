(* ::Package:: *)

(* 1. Declare the package and its public symbols *)
BeginPackage["TypstForm`"]

MakeTypstString::usage =
  "MakeTypstString[expr] returns a Typst-compatible string for expr.";

Begin["`Private`"]    (* ← note the backticks here *)

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
MakeTypstString[p_Power] /; p[[1]] === E := Module[{ex = p[[2]]},
  "e^(" <> MakeTypstString[ex] <> ")"
];
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
        MakeTypstString[matHead[x_]] :=
          typstName <> "(" <> MakeTypstString[x] <> ")"
      ]
    ]
  ],
  unaryMap
];
MakeTypstString[p_Power] := Module[{b, e},
  {b, e} = List @@ p;
  "(" <> MakeTypstString[b] <> ") ^ " <> MakeTypstString[e]
]
MakeTypstString[t_Times] :=
  StringRiffle[MakeTypstString /@ List @@ t, " * "];
MakeTypstString[a_Plus] :=
  StringRiffle[MakeTypstString /@ List @@ a, " + "];
MakeTypstString[Divide[a_, b_]] :=
  "(" <> MakeTypstString[a] <> ")/(" <> MakeTypstString[b] <> ")";
MakeTypstString[other_] := ToString[InputForm[other]];

End[]   (* closes `TypstForm`Private` *)
EndPackage[]
