unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}


uses UPearsonHash;

const
ptable:TPearsonTable = (
187, 38, 75, 195, 30, 39, 106, 36, 
74, 201, 31, 158, 194, 99, 192, 216, 
153, 222, 118, 22, 23, 189, 203, 32, 
172, 128, 175, 112, 180, 2, 90, 44, 
221, 146, 94, 86, 42, 104, 89, 52, 
113, 163, 174, 210, 58, 80, 96, 239, 
241, 219, 228, 135, 151, 186, 95, 20, 
204, 8, 1, 196, 18, 240, 205, 35, 
5, 119, 179, 225, 21, 100, 226, 27, 
254, 93, 108, 142, 105, 206, 247, 211, 
249, 223, 56, 190, 85, 115, 124, 157, 
6, 188, 120, 176, 133, 169, 73, 69, 
242, 67, 110, 66, 183, 34, 76, 59, 
64, 152, 166, 213, 143, 60, 71, 49, 
88, 97, 246, 7, 173, 9, 148, 136, 
193, 144, 28, 4, 191, 234, 41, 12, 
82, 232, 43, 50, 177, 209, 72, 251, 
248, 207, 202, 114, 46, 230, 123, 14, 
92, 37, 83, 181, 149, 155, 79, 77, 
122, 53, 159, 252, 125, 134, 109, 233, 
235, 253, 161, 47, 15, 65, 121, 224, 
91, 19, 131, 199, 63, 98, 101, 26, 
200, 147, 102, 162, 141, 13, 236, 137, 
11, 178, 255, 33, 164, 214, 139, 116, 
3, 40, 45, 87, 16, 51, 17, 129, 
244, 130, 217, 165, 170, 229, 227, 132, 
127, 29, 184, 107, 212, 167, 220, 168, 
103, 84, 185, 171, 138, 57, 231, 197, 
182, 61, 160, 55, 62, 0, 117, 126, 
238, 208, 10, 140, 48, 78, 218, 150, 
81, 68, 243, 215, 237, 198, 25, 245, 
145, 54, 250, 156, 154, 24, 111, 70 
);

tlist : array[0..255] of string = (
'hZdGu1MgCb|pPiYRy4zz0',  // 0
'',  // 1
'c7N6TEQXaJ|e2HGRSqajg|pr5ZTeypSa|V8qrAa4PwW',  // 2
'EVSVbw0M9h|kKQNu06V8u|qT9Lc7kSiT|RtNVD3SLsZ',  // 3
'CIRMeBQx6t|kWhTmyK5UI|mY4zrFfpIs',  // 4
'dxJ68spO5h',  // 5
'cN53qk18QG|Passwort',  // 6
'Maria',  // 7
'NqIk1yvvV4|Tasche',  // 8
'CgONRtAOSD|DHwm3M7Y3B|RoGqoh69TE|roRL7Io544',  // 9
'qkRPnvXaaE|schnackeln|WpDmiKvvXO',  // 10
'2eNLxSycim',  // 11
'',  // 12
'Programmieren',  // 13
'Bleibtreu',  // 14
'jC4cnaLrBt|Kampf',  // 15
'XvVKpvcLhT',  // 16
'',  // 17
'7JozoclCYo|9FZ0EgKHHg|L3v0her5Zr|MqiR2yuuvX|Python',  // 18
'Wanda',  // 19
'Schön|YUxIkfJuqC',  // 20
'FErr8I3GcQ|nAbVa4fzpk',  // 21
'ivs3I65TXb',  // 22
'aKFYKefkYm|schlafen',  // 23
'LMU1fMQXOd',  // 24
'bY1LNoEgjg|YPwwI5trE2',  // 25
'8m25DUIijm|hnXDzxvy4y|kPtVaEmkJL',  // 26
'08DwLJzefX|dgTxRFZLrS',  // 27
'uuBUE2OVc9',  // 28
'YrEwswWSqi',  // 29
'Tasse',  // 30
'Fischer',  // 31
'KQSpKUAZzG',  // 32
'Windows|Zange',  // 33
'fort|PCVc8zaWyJ',  // 34
'hHVQhXoua7|kQJdpAAPc4',  // 35
'W9GJU9CyQd',  // 36
'BBzH21X5NS',  // 37
'Ohr|oO7nkBQkLr|Prärie',  // 38
'l1rc1SUiUw',  // 39
'r6B9O7kASN|Silber',  // 40
'LaHj4gTusP|Wmn0MGY032',  // 41
'Hashing',  // 42
'SHCOOJswGc',  // 43
'Feeua7aQs1',  // 44
'9C35smYI3U|ZpCxoVTbC6',  // 45
'1UXgp5ilcz',  // 46
'eqpSQyyWPu|ov10gIlRSb|QlRESrqXLa',  // 47
'T5KnWcDRzT|xfQRijtkEq',  // 48
'Ende|uw1Wij5Bmq',  // 49
'cP0FHByUto',  // 50
'0byLAHOA0v|OaV8gRdby1|Trank',  // 51
'ig8c6BAYFk|iKaNnFHwGX',  // 52
'pAaKQfMOrd|Paul',  // 53
'1iGjSIBWIg',  // 54
'EmyJkjCnnm|X11ojN99Br|ZgTODhXUO3',  // 55
'6WKGrLoFad|jbbE4u4uy4|keOAotWeN5',  // 56
'Herz',  // 57
'Lunge',  // 58
'5xn9UXSOsq|Schnake',  // 59
'Bauarbeiter|HrVKMYvyVg|l5IqU5VxO5',  // 60
'SdqHBtsXkh',  // 61
'a9WjzGB5fQ',  // 62
'fkHkHbUmNE|Held|Hjp878gkxz|P4vWtvELRW',  // 63
'HVEqNuQN7O',  // 64
'dF5SB1hcEf|TQZLuebmO3',  // 65
'9Gbx8l5mI0',  // 66
'pjqTKDKAgj',  // 67
'8vKqZH4cXN|hUo620TQnM|iBs1INd8E0',  // 68
'oPQZL8eFYy',  // 69
'jNsrH3rN99|u1lnsPD8rB',  // 70
'Sn1Rua3K3N',  // 71
'Monitor',  // 72
'zlenEMJNvb',  // 73
'',  // 74
'GiEmPZcQCn|Idiot',  // 75
'Gold|NPJB4w7fzB|XoSeJCV6EC',  // 76
'trinken|WbV4IbwFhm',  // 77
'',  // 78
'WT6VLd0KUe|YXbCPJdy4i',  // 79
'Jz7iZlYNRK|UFsXMF0Ry2',  // 80
'schnell',  // 81
'L9ncF4YKqX',  // 82
'zQOSgQw1R1',  // 83
'',  // 84
'Frank|hässlich',  // 85
'8AM4fniN4H|Elefant|Schwein',  // 86
'0mHOKmIeS9',  // 87
'O9zJs5sqlU',  // 88
'BWW7Svl21G|L1jZTX7rdC',  // 89
'uE7Z9CrLLl',  // 90
'cfcV5Hj5Np|Computer',  // 91
'Zeilen',  // 92
'Perfekt',  // 93
'CYCNNLKRhD',  // 94
'8y5oWcXSuT|HLWRxB8yIT|hwheAI49yX',  // 95
'Trottel|VW',  // 96
'me7BNZD1rb',  // 97
'',  // 98
'Geld|kjjhB06xhK',  // 99
'16KiPNCTi6|bWWPn9kJlh|JJeq8Yql1A',  // 100
'1BHIKQqHHW',  // 101
'Katze',  // 102
'poppen',  // 103
'AdUIBJADKU|m9JLDWwZjy',  // 104
'Bier|Knie',  // 105
'ilgmeuDZSo|zoP3FW45ml',  // 106
'',  // 107
'8cO563Vztk|WT14uPIhxx',  // 108
'5DUWOG7u7g',  // 109
'',  // 110
'2V2pZ0TlN7',  // 111
'1iN4vWT6yc',  // 112
'Y91CHN0UoT',  // 113
'5sjttkdjNq|Hilfe',  // 114
'bfXxbCnlmy|kqUe0Qw5KB|pk8vLCyhq6',  // 115
'ZWN5lRSr9j',  // 116
'a1OlD5rE4v|Treibgut',  // 117
'',  // 118
'9sU2iZfCZh|CAWHCLDea1',  // 119
'IXgyiELvg3|YO2FePiLO0',  // 120
'Arrogant',  // 121
'rq4Lato2fr',  // 122
'',  // 123
'13s6OyJgtx|vBIgdwAMHG',  // 124
'9g1B43HcGj|OOP',  // 125
'HXQsw9dk5U',  // 126
'0AMSbIbE1N|Heuboden',  // 127
'b52VNPuSST|W56OCKVLH0|Y1ERlQiW3m|zJ2BZOnOuh',  // 128
'0wjVK7f647|O0ekaSvQ6J',  // 129
'hhhuYbelzn|kf6ry3JvQ8|WbQrU7D76K',  // 130
'Tasten|xNt2g3skNX',  // 131
'5COGLRXzoY|64lFq6bsVu|ZJ3pEEj6wL',  // 132
'Stier',  // 133
'MZobDtxqD6',  // 134
'djJjb6nIo9|PBXxUJYn4u|The art of coding',  // 135
'',  // 136
'hWrLQFzBml',  // 137
'4d1o7F5GBA|JyVv9Z5zdt|vjb6Mc1NbT',  // 138
'DQH2wCPvPG|G4gQP3y0wg',  // 139
'5b8NiRYYTt|Salat',  // 140
'Feile|Wer andern eine Grube gräbt|Wj3ykfBFUJ',  // 141
'DBrMMCha4v|Hand',  // 142
'nw7YZNZWsi|ul2MvuKCYK|Was soll das?',  // 143
'Blut|Plastik',  // 144
'NgGJ7DiKB4',  // 145
'nVfsfmruoL|Organisch|xDPr1y1NEq',  // 146
'anfall|BDk4gvzV06',  // 147
'j7iPOXjl4r|lHRxqMJuDp|Prolog',  // 148
'NxsNCYCpDX|QqxCFru1Cx|SuKC67dWQU',  // 149
'OfWLnvRPKw|wkpvkCuzgw',  // 150
'H1QfG0inRJ',  // 151
'JQoHPrj2Y3|kfi9dMvXIt',  // 152
'Langweilig|nr1v1iFj2F|yRcLTFnNwL',  // 153
'jkE3P9bXKZ|qnyfVvOiFf',  // 154
'',  // 155
'Xh7HU8Tt7D',  // 156
'N1YHe1a8XE|WgVIRF891F',  // 157
'3mn5UPMh50|keine',  // 158
'Dumm',  // 159
'blau|PIqhGBevi0',  // 160
'at least|mre23O78yn|Tor',  // 161
'',  // 162
'',  // 163
'OTs938QpHl',  // 164
'EQW6y0FqzI|lwktje7nLj|Unfall',  // 165
'',  // 166
'gh6vh5swOr|Ohne',  // 167
'',  // 168
'4TB7gnlpO5|dGnXhobkt6|For-Schleife',  // 169
'2hENqc12Ug|Delphi|Team Foundation Server sucks',  // 170
'Blitzkrieg',  // 171
'',  // 172
'kOkcjz8WAA|Maus',  // 173
'akQnxqLIcH|qGsG4zoijl',  // 174
'saufen',  // 175
'',  // 176
'i133n1Ww3O',  // 177
'j2OKiy3xaQ|kbrQz4xKr2',  // 178
'',  // 179
'Sofort',  // 180
'lJtHAVMcml|NR1JKaWtrU|qawCxrcMBD',  // 181
'911ItATqTC',  // 182
'fertig',  // 183
'',  // 184
'YAVGbOOfYl',  // 185
'Bitburger|tcT9MJtnpj',  // 186
'Aktien|kGpCHjptUe|Schwefel',  // 187
'br12flGyHe|vCNWd6UGlJ',  // 188
'Abstand|KwrA4B1m0S',  // 189
'e37cgkY3Df',  // 190
'EmtkaASQoe',  // 191
'3f3vJHw1W4|Bildschirm|D4wRYGHeFJ',  // 192
'MyarOxJ81K|Paulaner',  // 193
'10Q4gNmTzm',  // 194
'Dreck',  // 195
'mygvEWIWPV',  // 196
'mwv6586DKk',  // 197
'QvRKNSieqV',  // 198
'8HjIoHhb0m|Sf7zURBG8v',  // 199
'Datenbank|Krank|qFzf39WqNu',  // 200
'',  // 201
'80zCv1jQOs',  // 202
'0v6GkeCaKf|1vonS8FO8a|vyVWeAylH7',  // 203
'GONutWn4pL',  // 204
'Blei|Delphi-Praxis',  // 205
'12345|Hqcp0hEp8N',  // 206
'KWALI7iUpS|Nicht Gut',  // 207
'',  // 208
'mg99fjTehv',  // 209
'aCtN2zEvdb|Gehirn',  // 210
'73sXnQgrr5',  // 211
'Herbert|PWkwumIe7Z',  // 212
'Leber|RZ4Ug7m3aY',  // 213
'E6FAC2jn2L',  // 214
'Geheim',  // 215
'Fahrrad|Pause',  // 216
'NStKpGvLWN|oR735yJOc4',  // 217
'91j0F88AwV|Auto|S5JqgMIFXN',  // 218
'G1UGb31nId',  // 219
'Arm',  // 220
'Kaliber',  // 221
'L8M5lDvJ85|Vbl75CvDEp',  // 222
'Power|WlJ6K0MfZe',  // 223
'22w9sHqKeF|mfoIBAeXHp',  // 224
'5auMxWtDEX|7JOwti7TSV|Ejxbd9cIB2',  // 225
'Hallo|NtLLSxUoOo|OplOCzacdd',  // 226
'langsam',  // 227
'Zh1VCQ9DS8',  // 228
'',  // 229
'QtktKwWdQy|Schicksal|T0N9OWG3cp',  // 230
'lOd9l3sw5Q|Oqoorpu00p|RwJoM02XLH|Schüssel',  // 231
'http://www.embacadero.com|rcbkIQREsL',  // 232
'Xenia',  // 233
'Pearson',  // 234
'obst|Q62M6VKoau',  // 235
'7ExPGQTbWa|dI4Jjlf5uS',  // 236
'G000GUXlbF|TSbmEeAaDW',  // 237
'lv0R8IWSel|sL00ag7zEV',  // 238
'mmjiKt7EXR|Peter',  // 239
'rnHeM42MOk|tWhxrxz7FM',  // 240
'',  // 241
'AA3Sx7XdXP|ZznW8KIau4',  // 242
'lpfavunBgh|sXQfQuCuWv',  // 243
'',  // 244
'ajLR16f1l7',  // 245
'8Pgy1ETVES|hdpaxompxc|SWm8BWJs4j',  // 246
'Praxis|s5FEJzVJPY',  // 247
'',  // 248
'nW1Se8K0gm',  // 249
'Gleichung|U8FAVLt5In',  // 250
'',  // 251
'Dummkopf|uBIcCDiUrU',  // 252
'X5EQqbr7ls',  // 253
'Pech|V15mq75rGa',  // 254
'GoQUrUb0HS|mqrXqr110h'  // 255
);

function PHash(const s:string):Boolean;
var
  t:string;
begin
  t:= tlist[PearsonHash(ptable, s)];
  result := (Pos(s,t) > 0)
end;




procedure TForm1.Button1Click(Sender: TObject);
begin
   if PHash('Dummkopf') then
      Caption := 'OK';
end;

end.
