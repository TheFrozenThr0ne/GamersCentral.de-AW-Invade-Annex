//waitUntil {player == player};

_this spawn 
{
  while {true} do
  {
    if ((((driver vehicle player == player) && (_this select 5)) || 
    ((gunner vehicle player == player) && (_this select 4)) || 
    ((commander vehicle player == player) && (_this select 3))) && 
    ((vehicle player in (_this select 0)) || 
    (typeOf vehicle player in (_this select 0))) && 
    !((typeOf player in (_this select 1)) || 
    (player in (_this select 1)) || 
    (getPlayerUID player in (_this select 1)))) then
    {
      moveOut player;
      cutText [_this select 2, "PLAIN"];
    };
  sleep 0.1;
  };
};