unit LuaCrypto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, {$ifdef luajit}lua{$else}{$ifdef lua54}lua54{$else}lua53{$endif}{$endif};

implementation

uses
  LuaUtils, LuaPackage, BaseCrypto, synacode;

function crypto_hextostr(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, HexToStr(luaGetString(L, 1)));
  Result := 1;
end;

function crypto_strtohexstr(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, StrToHexStr(luaGetString(L, 1)));
  Result := 1;
end;

function crypto_md5hex(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, MD5Hex(luaGetString(L, 1)));
  Result := 1;
end;

function crypto_aesdecryptcbc(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, AESDecryptCBC(luaGetString(L, 1), luaGetString(L, 2), luaGetString(L, 3)));
  Result := 1;
end;

function crypto_AESDecryptCBCSHA256Base64Pkcs7(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, AESDecryptCBCSHA256Base64Pkcs7(luaGetString(L, 1), luaGetString(L, 2), luaGetString(L, 3)));
  Result := 1;
end;

// -- synacode

function lua_decodeurl(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, DecodeURL(luaGetString(L, 1)));
  Result := 1;
end;

function lua_encodeurl(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, EncodeURL(luaGetString(L, 1)));
  Result := 1;
end;

function lua_decodeuu(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, DecodeUU(luaGetString(L, 1)));
  Result := 1;
end;

function lua_encodeuu(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, EncodeUU(luaGetString(L, 1)));
  Result := 1;
end;

function lua_encodeurlelement(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, EncodeURLElement(luaGetString(L, 1)));
  Result := 1;
end;

function lua_decodebase64(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, DecodeBase64(luaGetString(L, 1)));
  Result := 1;
end;

function lua_encodebase64(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, EncodeBase64(luaGetString(L, 1)));
  Result := 1;
end;

function lua_crc16(L: Plua_State): Integer; cdecl;
begin
  lua_pushinteger(L, Crc16(luaGetString(L, 1)));
  Result := 1;
end;

function lua_crc32(L: Plua_State): Integer; cdecl;
begin
  lua_pushinteger(L, Crc32(luaGetString(L, 1)));
  Result := 1;
end;

function lua_md4(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, MD4(luaGetString(L, 1)));
  Result := 1;
end;

function lua_md5(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, MD5(luaGetString(L, 1)));
  Result := 1;
end;

function lua_hmac_md5(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, HMAC_MD5(luaGetString(L, 1), luaGetString(L, 2)));
  Result := 1;
end;

function lua_md5longhash(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, MD5LongHash(luaGetString(L, 1), lua_tointeger(L, 2)));
  Result := 1;
end;

function lua_sha1(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, SHA1(luaGetString(L, 1)));
  Result := 1;
end;

function lua_hmac_sha1(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, HMAC_SHA1(luaGetString(L, 1), luaGetString(L, 2)));
  Result := 1;
end;

function lua_sha1longhash(L: Plua_State): Integer; cdecl;
begin
  lua_pushstring(L, SHA1LongHash(luaGetString(L, 1), lua_tointeger(L, 2)));
  Result := 1;
end;

procedure luaSynaCodeRegister(L: Plua_State);
begin
  luaPushFunctionGlobal(L, 'DecodeURL', @lua_decodeurl);
  luaPushFunctionGlobal(L, 'EncodeURL', @lua_encodeurl);
  luaPushFunctionGlobal(L, 'DecodeUU', @lua_decodeuu);
  luaPushFunctionGlobal(L, 'EncodeUU', @lua_encodeuu);
  luaPushFunctionGlobal(L, 'EncodeURLElement', @lua_encodeurlelement);
  luaPushFunctionGlobal(L, 'DecodeBase64', @lua_decodebase64);
  luaPushFunctionGlobal(L, 'EncodeBase64', @lua_encodebase64);
  luaPushFunctionGlobal(L, 'CRC16', @lua_crc16);
  luaPushFunctionGlobal(L, 'CRC32', @lua_crc32);
  luaPushFunctionGlobal(L, 'MD4', @lua_md4);
  luaPushFunctionGlobal(L, 'MD5', @lua_md5);
  luaPushFunctionGlobal(L, 'HMAC_MD5', @lua_hmac_md5);
  luaPushFunctionGlobal(L, 'MD5LongHash', @lua_md5longhash);
  luaPushFunctionGlobal(L, 'SHA1', @lua_sha1);
  luaPushFunctionGlobal(L, 'HMAC_SHA1', @lua_hmac_sha1);
  luaPushFunctionGlobal(L, 'SHA1LongHash', @lua_sha1longhash);
end;

const
  cryptomethods: packed array [0..5] of luaL_Reg = (
    (name: 'HexToStr'; func: @crypto_hextostr),
    (name: 'StrToHexStr'; func: @crypto_strtohexstr),
    (name: 'MD5Hex'; func: @crypto_md5hex),
    (name: 'AESDecryptCBC'; func: @crypto_aesdecryptcbc),
    (name: 'AESDecryptCBCSHA256Base64Pkcs7'; func: @crypto_AESDecryptCBCSHA256Base64Pkcs7),
    (name: nil; func: nil)
    );

  synacodemethods: packed array [0..16] of luaL_Reg = (
    (name: 'DecodeURL'; func: @lua_decodeurl),
    (name: 'EncodeURL'; func: @lua_encodeurl),
    (name: 'DecodeUU'; func: @lua_decodeuu),
    (name: 'EncodeUU'; func: @lua_encodeuu),
    (name: 'EncodeURLElement'; func: @lua_encodeurlelement),
    (name: 'DecodeBase64'; func: @lua_decodebase64),
    (name: 'EncodeBase64'; func: @lua_encodebase64),
    (name: 'CRC16'; func: @lua_crc16),
    (name: 'CRC32'; func: @lua_crc32),
    (name: 'MD4'; func: @lua_md4),
    (name: 'MD5'; func: @lua_md5),
    (name: 'HMAC_MD5'; func: @lua_hmac_md5),
    (name: 'MD5LongHash'; func: @lua_md5longhash),
    (name: 'SHA1'; func: @lua_sha1),
    (name: 'HMAC_SHA1'; func: @lua_hmac_sha1),
    (name: 'SHA1LongHash'; func: @lua_sha1longhash),
    (name: nil; func: nil)
    );

function luaopen_crypto(L: Plua_State): Integer; cdecl;
begin
  luaNewLibTable(L, [cryptomethods, synacodemethods]);
  Result := 1;
end;

initialization
  LuaPackage.AddLib('crypto', @luaopen_crypto);

end.

