program main;

{$mode objfpc}{$H+}

uses Crt;

const
  width = 10;
  height = 10;
  walls = 50;

type
  THero = record
    x, y, health: integer;
  end;

var
  map: array [1..width] of array [1..height] of char;
  hero: THero;
  i, j: integer;

  procedure PrintMap();
  var i, j: integer;
  begin
    GotoXY(1, 1);
    For i := 1 to height do begin
      For j := 1 to width do
        if (j = hero.x) and (i = hero.y) then begin
          if hero.health = 3 then TextColor(Green);
          if hero.health = 2 then TextColor(LightGreen);
          if hero.health = 1 then TextColor(Yellow);
          write('H');
          TextColor(LightGray);
        end else begin
          if map[j][i] = '#' then TextColor(Red);
          if map[j][i] = '*' then TextColor(Magenta);
          write(map[j][i]);
          TextColor(LightGray);
        end;
      writeln;
    end;
    GotoXY(width + 2, height div 2);
    writeln(hero.health, '/3');
  end;

begin
  Randomize;
  hero.x := 1;
  hero.y := 1;
  hero.health := 3;
  For i := 1 to width do
    For j := 1 to height do
      map[i][j] := '.';
  For i := 1 to walls do
    map[Random(width)+1][Random(height)+1] := '#';
  map[width][height] := '*';
  cursoroff;
  While True do begin
    PrintMap();
    if KeyPressed Then begin
      case ReadKey of
      'w', 'W': if hero.y > 1 then hero.y -= 1;
      'd', 'D': if hero.x < width then hero.x += 1;
      's', 'S': if hero.y < height then hero.y += 1;
      'a', 'A': if hero.x > 1 then hero.x -= 1;
      end;
      if map[hero.x][hero.y] = '#' then hero.health -= 1;
      if hero.health = 0 then break;
      if map[hero.x][hero.y] = '*' then break;
    end;
  end;
  ClrScr;
  if hero.health = 0 then writeln('game over')
  else writeln('VICTORY!!11');
  readln;
end.

