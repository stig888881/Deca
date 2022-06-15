function [Ep,FamT,Fatm,Fprom,Fsp] = FindEp (f0,f0F2,t,prom,B)

koef=4.343;
if (t>=0) && (t<=4)
    Fatm=[117 102 92.5 82.5 76 70 62.5 59.5 57 54 49 40 15 -10];    %Зависит от координат и времени года+суток!!!!!
    sigmFatm=[5 5.5 5.75 5.9 5.75 5.6 5 4.8 4.5 4.3 4.1 4 4 4];
elseif (t>=12) && (t<=16)        
    Fatm=[117 100 90 77.5 70 60 45 38 36 35 35 35.4 22.5 -12.5];    %Зависит от координат и времени года+суток!!!!!
    sigmFatm=[6.9 8.2 8.9 9.25 9.25 9 8.1 7.25 6.5 6 5.25 4.5 4 4];
end
luf=[0.1 0.2 0.3 0.5 0.7 1 2 3 4 5 7 10 20 30];
Fatm=spline(luf,Fatm,f0);

sigmFatm=spline(luf,sigmFatm,f0);

if (prom==1)
    sigmp=11/1.282;
    c=76.8;
    d=27.7;
elseif (prom==3)
    sigmp=9.2/1.282;
    c=67.2;
    d=27.7;
elseif (prom==4)
    sigmp=9.2/1.282;
    c=53.6;
    d=28.6;
end
Fsp=52-23*log10(f0);
Fprom=c-d*log10(f0);

clear alfat;
for i=1:length(f0)
    alfap(i)=exp((c-d*log10(f0(i)))/koef+sigmp^2/(2*koef^2));     %учет промышленных шумов 6.8
    alfaatm(i)=exp(Fatm(i)/koef+sigmFatm(i)^2/(2*koef^2));                   %учет атмосферных шумов
    if f0(i)>f0F2
        alfasp(i)=exp((52-23*log10(f0(i)))/koef+1.56^2/(2*koef^2));    %учет галактических шумов
    else alfasp(i)=0;
    end
    alfat(i)=alfap(i)+alfaatm(i)+alfasp(i);
end
clear bett;
for i=1:length(f0)
    betp(i)=alfap(i)^2*(exp(sigmp^2/koef^2)-1);    %учет промышленных шумов
    betatm(i)=alfaatm(i)+exp(sigmFatm(i)^2/koef^2)-1;    %учет атмосферных шумов
    if f0(i)>f0F2
        betsp(i)=alfasp(i)+exp(1.56^2/koef^2)-1;   %учет галактических шумов
    else betsp(i)=0;
    end
    bett(i)=betp(i)+betatm(i)+betsp(i);
end

clear sigmat;
for i=1:length(f0)
    sigmat(i)=koef*(log(1+bett(i)/alfat(i)^2))^(1/2);
end
clear FamT;
for i=1:length(f0)
    FamT(i)=koef*(log(alfat(i))-sigmat(i)^2/(2*koef^2));
end

clear Ep;
for i=1:length(f0)
    Ep(i)=FamT(i)+20*log10(f0(i))+10*log10(B)-96.8;% 10*log10(1000) - помехи для ширины канала в 1 кГц
end
end