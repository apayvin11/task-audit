%��������
%������� �����-������ (sh)
name(sh).
%������� ���-������ (kk)
name(kk).
%���� �������� (ll)
name(ll).

%��� ����������� � ��������:
%������� ���������� (vb)
town(vb).
%������ �������� (nm)
town(nm).
%��������� (p)
town(p).

%��� ������
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

    %3 ������ ��������
    name(X), name(Y), name(Z),
    unique([X, Y, Z]),

    %������ ������ � ������ ����
    day(XDay), day(YDay), day(ZDay),
    unique([XDay, YDay, ZDay]),

    %������ ������ �� ������ �������
    town(XTown), town(YTown), town(ZTown),
    unique([XTown, YTown, ZTown]),

    %1 �������: �� �� ���� � ��
    not(member(auditor(sh, _, nm), Solve)),

    %2 �������: �� �� ������ ������� � �� ��� ��, �� ������ �� �� �������
    not(member(auditor(kk, tuesday, nm), Solve)),
    not(member(auditor(kk, tuesday, vb), Solve)),

    %3 �������: �� �� ������ � �� � �����������
    not(member(auditor(kk, monday, vb), Solve)),

    %4 �������: ����� �� ������ � �� � �����������
    not(member(auditor(_, monday, nm), Solve)),

    %5 �������: �� �� ���� � ��
    not(member(auditor(sh, _, vb), Solve)),

    %6 �������: �� ����� ����� � ��������� �� �� � �����������
    not(member(auditor(sh, monday, p), Solve)).

start(Solve):-
  solve(Solve),
  Solve = [auditor(ll, _, _), auditor(sh, _, _), auditor(kk, _, _)].
