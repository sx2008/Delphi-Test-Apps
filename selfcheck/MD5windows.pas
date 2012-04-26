unit MD5windows;

interface


type
   MD4_CTX  = packed record
    _Buf    : array[0..3] of LongWord;
    _I      : array[0..1] of LongWord;
    input   : array[0..63] of byte;
    digest  : Array[0..15] of Byte;
   end;


Procedure MD4Init(Var Context: MD4_CTX); StdCall;
Procedure MD4Update(Var Context: MD4_CTX; const Input; inLen: LongWord); StdCall;
Procedure MD4Final(Var Context: MD4_CTX); StdCall;



type
  MD5_CTX = packed Record
    i:      Array[0.. 1] of LongWord;
    buf:    Array[0.. 3] of LongWord;
    input:  Array[0..63] of Byte;
    digest: Array[0..15] of Byte;
  End;


Procedure MD5Init(Var Context: MD5_CTX); StdCall;
Procedure MD5Update(Var Context: MD5_CTX; const Input; inLen: LongWord); StdCall;
Procedure MD5Final(Var Context: MD5_CTX); StdCall;


// SHA1

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
   LIB_ADVAPI32 = 'advapi32.dll';


Procedure MD4Init; external LIB_ADVAPI32;
Procedure MD4Update; external LIB_ADVAPI32;
Procedure MD4Final; external LIB_ADVAPI32;

Procedure MD5Init; external LIB_ADVAPI32;
Procedure MD5Update; external LIB_ADVAPI32;
Procedure MD5Final; external LIB_ADVAPI32;

procedure A_SHAInit; external LIB_ADVAPI32;
procedure A_SHAUpdate; external LIB_ADVAPI32;
procedure A_SHAFinal; external LIB_ADVAPI32;



function SHA_Selftest:Boolean;
const
   // FIPS PUB 180.1 example A.1
   digest_abc : array[0..19] of Byte = (
		$a9, $99, $3e, $36, $47, $06, $81, $6a, $ba, $3e,
		$25, $71, $78, $50, $c2, $6c, $9c, $d0, $d8, $9d );
   test : AnsiString = 'abc';
var
   context: SHA_CTX;
   digest : SHA_DIG;
begin
   A_SHAInit(context);
   A_SHAUpdate(context, test[1], Length(test));
   A_SHAFinal(context, digest);

   Result := CompareMem(@digest_abc[0], @digest, sizeof(digest));
end;


end.
