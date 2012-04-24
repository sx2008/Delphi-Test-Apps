unit MD5windows;

interface

Type
  MD5_CTX = packed Record
    i:      Array[0.. 1] of LongWord;
    buf:    Array[0.. 3] of LongWord;
    input:  Array[0..63] of Byte;
    digest: Array[0..15] of Byte;
  End;


Procedure MD5Init(Var Context: MD5_CTX); StdCall;
Procedure MD5Update(Var Context: MD5_CTX; Input: Pointer; inLen: LongWord); StdCall;
Procedure MD5Final(Var Context: MD5_CTX); StdCall;

type
  SHA_CTX = packed record
   	Unknown : array[0..5] of LongWord;
	   State   : array[0..4] of LongWord;
	   Count   : array[0..1] of LongWord;
    	Buffer  : array[0..63] of Byte;
  end;

  SHA_DIG = packed record
	   Dig     : array[0..19] of Byte;
  end;

procedure A_SHAInit(var Context: SHA_CTX); StdCall;
procedure A_SHAUpdate(var Context: SHA_CTX; const Input; inlen: LongWord); StdCall;
procedure A_SHAFinal(var Context: SHA_CTX; out Digest:SHA_DIG); StdCall;

function SHA_Selftest:Boolean;



implementation

uses SysUtils;

const
   lib = 'advapi32.dll';

Procedure MD5Init(Var Context: MD5_CTX); StdCall;
  External lib Name 'MD5Init';
Procedure MD5Update(Var Context: MD5_CTX; Input: Pointer; inLen: LongWord); StdCall;
  External lib Name 'MD5Update';
Procedure MD5Final(Var Context: MD5_CTX); StdCall;
  External lib Name 'MD5Final';


procedure A_SHAInit(var Context: SHA_CTX); StdCall;External lib;
procedure A_SHAUpdate(var Context: SHA_CTX; const Input; inlen: LongWord); StdCall;External lib;
procedure A_SHAFinal(var Context: SHA_CTX; out Digest:SHA_DIG); StdCall;External lib;




function SHA_Selftest:Boolean;
const
   digest_abc : array[0..19] of Byte = (
		$a9, $99, $3e, $36, $47, $06, $81, $6a, $ba, $3e,
		$25, $71, $78, $50, $c2, $6c, $9c, $d0, $d8, $9d );

var
   context: SHA_CTX;
   digest : SHA_DIG;
   test : AnsiString;
begin
   test := 'abc';
   A_SHAInit(context);
   A_SHAUpdate(context, test[1], Length(test));
   A_SHAFinal(context, digest);
   //digest.Dig[0] := 1;

   Result := CompareMem(@digest_abc[0], @digest, sizeof(digest));
end;


end.
