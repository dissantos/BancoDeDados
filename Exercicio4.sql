-- EXERCICIO 4

-- Diego Santos Goncalves                   20183012537
-- Mariana Bulgarelli Alves dos Santos      20183000330

-- ***********************************************************************************************
-- 1) Apresente o nome do cliente e o total de compras para cada cliente.
select cliente.name as Nome, sum(o.total) as Soma, count(*) as Quantidade
from customer cliente , ord o 
where cliente.custid=o.custid 
group by cliente.name;

-- NOME                                                SOMA QUANTIDADE
-- --------------------------------------------- ---------- ----------
-- VOLLYRITE                                        27775,5          5
-- EVERY MOUNTAIN                                    7160,8          4
-- JOCKSPORTS                                        5280,9          4
-- JUST TENNIS                                          764          1
-- K + T SPORTS                                       46370          1
-- TKB SPORT SHOP                                     101,4          1
-- SHAPE UP                                          9024,4          3
-- NORTH WOODS HEALTH AND FITNESS SUPPLY CENTER        6400          1
-- WOMENS SPORTS                                        710          1


-- 2) Exiba cada produto pedido e o seu preco medio (media de ITEM.ACTUALPRICE).
select prod.prodid as Produto, prod.descrip as Descricao, round(avg(i.actualprice)) as "Preco Medio"
from product prod , item i 
where prod.prodid=i.prodid 
group by prod.prodid, prod.descrip;

--    PRODUTO DESCRICAO                      Preco Medio
-- ---------- ------------------------------ -----------
--    100860 ACE TENNIS RACKET I                     38
--    100861 ACE TENNIS RACKET II                    43
--    100870 ACE TENNIS BALLS-3 PACK                  7
--    100871 ACE TENNIS BALLS-6 PACK                  6
--    100890 ACE TENNIS NET                          57
--    101860 SP TENNIS RACKET                        24
--    101863 SP JUNIOR RACKET                        11
--    102130 RH: GUIDE TO TENNIS                      3
--    200376 SB ENERGY BAR-6 PACK                     2
--    200380 SB VITA SNACK-6 PACK                     4
    
-- 3) Liste o total de vendas (soma de ORD.TOTAL) por empregado.
select empregado.ename as Nome, sum(o.total) as "Total de vendas"
from emp empregado join customer cliente 
on empregado.empno = cliente.repid join ord o
on cliente.custid = o.custid 
group by empregado.ename;

-- NOME       Total de vendas
-- ---------- ---------------
-- WARD                9889,8
-- MARTIN             27775,5
-- ALLEN               7870,8
-- TURNER             58050,9

-- 4) Apresente o total (soma de ORD.TOTAL) e a media (media de ORD.TOTAL) de vendas por cidade.
select cliente.city as Cidade, sum(o.total) as Total, round(avg(o.total)) as "Media vendas por cidade"
from customer cliente, ord o 
where cliente.custid = o.custid 
group by cliente.city; 

-- CIDADE                              TOTAL Media vendas por cidade
-- ------------------------------ ---------- -----------------------
-- REDWOOD CITY                        101,4                     101
-- PALO ALTO                          9024,4                    3008
-- BURLINGAME                        28539,5                    4757
-- SANTA CLARA                         46370                   46370
-- HIBBING                              6400                    6400
-- CUPERTINO                          7160,8                    1790
-- SUNNYVALE                             710                     710
-- BELMONT                            5280,9                    1320

-- 5) Identifique o produto mais vendido (ou seja, maior soma de quantidade de itens), apresentando a quantidade
-- de vezes que ele foi pedido.
select item.prodid as Codigo, prod.descrip as Produto, sum(item.qty) as Soma
from item item join product prod
on prod.prodid = item.prodid
group by item.prodid, prod.descrip 
having sum(item.qty) = (select max(soma) 
    from (select sum(item.qty) soma 
        from professor.item item 
        group by item.prodid));

--    CODIGO PRODUTO                              SOMA
------------ ------------------------------ ----------
--    100870 ACE TENNIS BALLS-3 PACK              2288
    
-- 6) Exiba o pedido com mais itens (contar os itens), apresentando essa quantidade de itens.
select item.ordid as "PEDIDO COM MAIS ITENS", count(*) as Quantidade
from item item
group by item.ordid 
having count(*) =(select max(cont_itens.quant) 
    from (select count(*) quant 
        from item item 
        group by item.ordid) cont_itens);

--PEDIDO COM MAIS ITENS QUANTIDADE
----------------------- ----------
--                  617         10
                  
--7) Apresente o total de vendas (soma de ORD.TOTAL) para os empregados que sao supervisores de outros empregados.
select emp.ename as Supervisores, sum(o.total) as "TOTAL DE VENDAS"
from emp emp join customer cliente
on emp.empno = cliente.repid join ord o 
on cliente.custid = o.custid 
where empno in (select emp2.mgr 
    from emp emp2 
    where emp2.mgr is not null) 
group by emp.ename;

-- SUPERVISOR TOTAL DE VENDAS
------------- ---------------


-- 8) Apresente a faixa salarial de cada empregado (coluna SALGRADE.GRADE), assim como o seu nome e o
-- seu proprio salario.
select emp.ename as Nome, emp.sal as Salario, salario.grade as Faixa
from emp emp, salgrade salario
where emp.sal between salario.losal and salario.hisal;

--NOME          SALARIO      FAIXA
------------ ---------- ----------
--JAMES             950          1
--SMITH             800          1
--ADAMS            1100          1
--MARTIN           1250          2
--WARD             1250          2
--MILLER           1300          2
--ALLEN            1600          3
--TURNER           1500          3
--BLAKE            2850          4
--CLARK            2450          4
--JONES            2975          4
--FORD             3000          4
--SCOTT            3000          4
--KING             5000          5

-- 9) Faca uma consulta para verificar se existe algum empregado que nao esta em nenhuma das faixas salariais
-- da tabela SALGRADE. Se existir, apresente o nome e o salario do empregado.
select ename as Nome, sal as Salario
from emp
where empno not in (select e.empno 
    from emp e, salgrade s 
    where e.sal between s.losal and s.hisal);

-- NOME SALARIO
-- ---- -------
