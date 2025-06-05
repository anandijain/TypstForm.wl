
usage:
```wl
Get["https://raw.githubusercontent.com/anandijain/TypstForm.wl/refs/heads/main/Kernel/TypstForm.m"];

MakeTypstString[Sin[\[Theta]] + E^(\[Pi] + \[Alpha])]

Get["https://raw.githubusercontent.com/anandijain/TypstForm.wl/main/Tests/MakeTypstStringTests.wl"];

report = TestReport[tests];

failures = Select[report["TestResults"], #["Outcome"] === "Failure" &];

(* 4. Display those failed TestObjects: *)
Column[{
  "Failed test IDs:",
  Keys[failures],
  
  "Detailed failure objects:",
  Map[failures[#] &, Keys[failures]]
}]
```