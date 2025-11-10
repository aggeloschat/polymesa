clear;

A = [ 1     9    17    25    -33    41    49    57;
      2    1    8    2    4    2    50    58;
      2    10    18    26    34    2    0    8;
      -2    15    18    26    34    2    0    58;
      0    1    18    26    34    40    5    5;
      2    1    18    26    14    19    5    8;
      2    0    8    26    2    42   0    5;
      2    1    8    26    4    4    0    58;
  ];

result_one = mydct2(A);
result_two = dct2(A);

% Sygkrinoume th diafora
diff = result_one - result_two;

