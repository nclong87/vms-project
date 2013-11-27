--------------------------------------------------------
--  DDL for Function TIME_BETWEEN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."TIME_BETWEEN" (
p_from in date,
p_end in date
) RETURN varchar2 AS
l_cursor SYS_REFCURSOR;
v_year number;
v_month number;
v_day number;
v_d1 date;
v_d2 date;
v_maxday number;
BEGIN
  v_d1 := trunc(trunc(p_from, 'MM'), 'MM');
  v_d2 := LAST_DAY(p_end);
  if(p_from = v_d1 and p_end = v_d2) then
    v_month := floor(MONTHS_BETWEEN (v_d2, v_d1)) + 1;
    v_day := 0;
  elsif (p_from = v_d1) then
    v_d2 := trunc(trunc(p_end, 'MM'), 'MM');
    v_month := floor(MONTHS_BETWEEN (v_d2, v_d1));
    v_day := p_end - v_d2 + 1;
  elsif (p_end = v_d2) then
    v_d1 := LAST_DAY(p_from) + 1;
    v_month := floor(MONTHS_BETWEEN (v_d2, v_d1)) + 1;
    v_day := v_d1 - p_from;
  else
    v_d1 := LAST_DAY(p_from) + 1;
    v_d2 := trunc(trunc(p_end, 'MM'), 'MM');
    if(v_d1 > p_end) then
      v_month := 0;
      v_day := p_end - p_from + 1;
    else
      v_month := floor(MONTHS_BETWEEN (v_d2, v_d1));
      v_day := (v_d1 - p_from) + (p_end - v_d2)+1;
      v_maxday := extract(day from LAST_DAY(p_from));
      if(v_day >= v_maxday) then
        v_month := v_month + 1;
        v_day := v_day - v_maxday;
      end if;
      --dbms_output.put_line(to_char(p_end)||to_char(v_d2));
    end if;
  end if;
  RETURN v_month||','||v_day;
END TIME_BETWEEN;

/

