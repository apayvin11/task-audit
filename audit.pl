%Ревизоры
%Иермоша Сеель-Хамоша (sh)
name(sh).
%Казмера Киш-Киралю (kk)
name(kk).
%Лоле Латсатхи (ll)
name(ll).

%три предприятия в поселках:
%Верхний Большеград (vb)
town(vb).
%Нижний Малоград (nm)
town(nm).
%Плутоград (p)
town(p).

%Дни недели
day(monday).
day(tuesday).
day(wednesday).

auditor(Name, Day, Town).

unique([]):-!.
unique([Head|Tail]):-
   member(Head, Tail), !, fail;
   unique(Tail).

solve(Solve):-

    Solve = [auditor(X, XDay, XTown),
             auditor(Y, YDay, YTown),
             auditor(Z, ZDay, ZTown)],

    %3 разных ревизора
    name(X), name(Y), name(Z),
    unique([X, Y, Z]),

    %каждый поехал в разный день
    day(XDay), day(YDay), day(ZDay),
    unique([XDay, YDay, ZDay]),

    %каждый поехал на разную фабрику
    town(XTown), town(YTown), town(ZTown),
    unique([XTown, YTown, ZTown]),

    %1 условие: СХ не едет в НМ
    not(member(auditor(sh, _, nm), Solve)),

    %2 условие: КК не против поездки в НМ или ВБ, но только не во вторник
    not(member(auditor(kk, tuesday, nm), Solve)),
    not(member(auditor(kk, tuesday, vb), Solve)),

    %3 условие: КК не поедет в ВБ в понедельник
    not(member(auditor(kk, monday, vb), Solve)),

    %4 условие: никто не поедет в НМ в понедельник
    not(member(auditor(_, monday, nm), Solve)),

    %5 условие: СХ не едет в ВБ
    not(member(auditor(sh, _, vb), Solve)),

    %6 условие: СХ может ехать в Плутократ но не в понедельник
    not(member(auditor(sh, monday, p), Solve)).

start(Solve):-
  solve(Solve),
  Solve = [auditor(ll, _, _), auditor(sh, _, _), auditor(kk, _, _)].
