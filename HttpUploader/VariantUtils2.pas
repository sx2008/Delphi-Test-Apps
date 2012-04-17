unit VariantUtils2;

interface

{uses Variants; //Delphi 7 und höher}

function VarByteArrayCreate2(const s:AnsiString):Variant;
function VarByteArrayToString(v:Variant):AnsiString;


implementation


function VarByteArrayCreate2(const s:AnsiString):Variant;
var
   data : Pointer;
begin
   if s<>'' then
   begin
      Result := VarArrayCreate([0, Length(s)-1], varByte);
      data := VarArrayLock(Result);
      try
         Move(s[1], data^, Length(s));
      finally
         VarArrayUnlock(Result);
      end;
   end
   else
      Result := Null;
end;



function VarByteArrayToString(v:Variant):AnsiString;
var
   len : Integer;
   data : Pointer;
begin
   Assert(VarType(V) = varByte or varArray);
   Assert(VarArrayDimCount(V) = 1);

   len := VarArrayHighBound(v,1)-VarArrayLowBound(v,1)+1;
   SetLength(result, len);

   data := VarArrayLock(v);
   try
      Move(data^, Result[1], len);
   finally
      VarArrayUnlock(v);
   end;
end;


end.
