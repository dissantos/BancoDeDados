--1) Apresente o nome do cliente e o total de compras para cada cliente
select c.name, sum(o.total) 
from PROFESSOR.customer c, PROFESSOR.ord o
where c.custid = o.custid
group by c.name;

select c.name, sum(o.total), count(*) 
from customer c join ord o on c.custid=o.custid 
group by c.name;

--2) Exiba cada produto pedido e o seu preço médio (média de ITEM.ACTUALPRICE).
select p.prodid, p.descrip, round(avg(i.actualprice)) 
from product p join item i 
on p.prodid=i.prodid 
group by p.prodid, p.descrip;

--3) Liste o total de vendas (soma de ORD.TOTAL) por empregado.
select e.ename, sum(o.total) 
from PROFESSOR.ord o,PROFESSOR.emp e, PROFESSOR.customer c
where e.empno = c.repid and c.custid = o.custid
group by e.ename;

select e.ename, sum(o.total) 
from professor.emp e join PROFESSOR.customer c 
on e.empno = c.repid join professor.ord o 
on c.custid = o.custid 
group by e.ename;


--4) Apresente o total (soma de ORD.TOTAL) e a média (média de ORD.TOTAL) de vendas por cidade
select c.city, sum(o.total), round(avg(o.total)) 
from professor.ord o join professor.customer c 
on o.custid = c.custid
group by c.city;

--5) Identifique o produto mais vendido (ou seja, maior soma de quantidade de itens), apresentando a quantidade
--de vezes que ele foi pedido.
select sum(i.qty) soma from professor.item i group by i.prodid;
select max(soma) from (select sum(i.qty) soma from professor.item i group by i.prodid);

select i.prodid, sum(i.qty) 
from professor.item i 
group by i.prodid 
having sum(i.qty) = (select max(soma) 
    from (select sum(i.qty) soma 
        from professor.item i 
        group by i.prodid));
        
--6) Exiba o pedido com mais itens (contar os itens), apresentando essa quantidade de itens.
select i.ordid, count(*) 
from Professor.item i 
group by i.ordid 
having count(*) =(select max(cont_itens.quant) 
    from (select count(*) quant 
        from item i 
        group by i.ordid) cont_itens);

--7) Apresente o total de vendas (soma de ORD.TOTAL) para os empregados que são supervisores de outros
--empregados. 
select e.ename, sum(o.total) 
from emp e join customer c 
on e.empno = c.repid join ord o 
on c.custid = o.custid 
where empno in ( select e2.mgr 
    from emp e2 
    where e2.mgr is not null) 
group by e.ename;

select s.ename, sum(o.total)
from professor.emp e, professor.emp s, professor.ord o, professor.customer c
where s.empno=e.mgr and c.repid=s.empno and o.custid=c.custid
group by s.ename;

--8) Apresente a faixa salarial de cada empregado (coluna SALGRADE.GRADE), assim como o seu nome e o
--seu próprio salário.
select e.ename, e.sal, s.grade 
from emp e, salgrade s 
where e.sal between s.losal and s.hisal;

--9) Faça uma consulta para verificar se existe algum empregado que não está em nenhuma das faixas salariais
--da tabela SALGRADE. Se existir, apresente o nome e o salário do empregado.
select e.ename, e.sal
from emp e 
where not exists(select *
    from salgrade s 
    where e.sal between s.losal and s.hisal);
    
select ename ,sal
from emp 
where empno not in (select e.empno 
    from emp e, salgrade s 
    where e.sal between s.losal and s.hisal);

