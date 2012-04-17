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

implementation

const
   lib = 'advapi32.dll';

Procedure MD5Init(Var Context: MD5_CTX); StdCall;
  External lib Name 'MD5Init';
Procedure MD5Update(Var Context: MD5_CTX; Input: Pointer; inLen: LongWord); StdCall;
  External lib Name 'MD5Update';
Procedure MD5Final(Var Context: MD5_CTX); StdCall;
  External lib Name 'MD5Final';




end.
