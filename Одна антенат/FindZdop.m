function [f0, zdop,u0, zdopy] = FindZdop (fcrF2,r,hm,bet)

%Параметры из справочниковы
c=3*10^8;   %Скорость света
h0=2.5*10^5;         %Нижняя граница ионосферы
R0=6370*10^3;   %Радиус Земли
r0=5*10^2;      %Наибольший размер ионосферных неоднородностей
h=1:1:10000;
FvFcr=0.1:0.01:0.9;
Fv=fcrF2*FvFcr;


Zm=hm-h0;

hw=round((h0+Zm.*FvFcr./2.*log((1+FvFcr)./(1-FvFcr))));
secfi=(1+r^2./(4.*(hw+r^2/(8*R0)).^2)).^0.5;
f0=secfi.*Fv;
for i=1:length(f0)
    Leq(i)=(hw(i)-h0)*(secfi(i)^2-0.5.*(1+(fcrF2/Fv(i))^2-Zm/(hw(i)-h0)))^0.5*(1+(fcrF2/Fv(i))^2-Zm/(hw(i)-h0)); 
fr=f0*10^(-6);
end
secfim=(1+r^2./(4.*(hm+r^2/(8*R0)).^2)).^0.5;
    Leqm=(hm-h0)*(secfim^2-0.5*(1+1)^2-Zm/(hm-h0))^0.5*(1+1)^2-Zm/(hm-h0); 
fr=secfim*fcrF2;
        sigma2m=2*r0*Leqm*((pi*0.005*fr)/(c*secfim^2))^2;
                mm=((1-exp(1)^(-2*sigma2m))^-1)*1;
                        zdopm=10*log10(2*mm*((2*(3*10^-3))^(-1/mm)-1));
for j=1:length(bet)
    for i=1:length(Leq)
        sigma2(j,i)=2*r0*Leq(i)*((pi*bet(j)*f0(i))/(c*secfi(i)^2))^2;
        sqr(j,i)=sqrt(sigma2(j,i));
        m(i)=((1-exp(1)^(-2*sigma2(j,i)))^-1)*1;
        y(i)=((exp(1)^sigma2(j,i))-1)^-1;
           H(i,j)=((1+y(i))*(exp(-y(i))))/(3*10^-3);
        zdopy(i)=10*log10(((1+y(i))*(exp(-y(i))))/(3*10^-3));
        zdopy2(i,j)=10*log10((((3*(1+y(i))^2)*(exp(-2*y(i))))/(3*10^-3)).^(1/2));
        zdopy3(i,j)=10*log10((((10*(1+y(i))^3)*(exp(-3*y(i))))/(3*10^-3)).^(1/3));
        zdop(i,j)=10*log10(2*m(i)*((2*(3*10^-4))^(-1/m(i))-1));
        Zbz(i,j)=zdop(i,j)-10*log10(-2*log(2*3*10^-3));
        Km=10*log10(-2*log(2*3*10^-3));
       T(i)=13*Zbz(i,j)*Km*sqrt(0.3*10^-3/(0.25*1*3*2));
        u=@(h)(((y(i)+1)./(h+2.*(y(i)+1))).*(exp(-(y(i).*h)./(h+2.*(y(i)+1))))-3*10^(-4));
u0(i,j)=fzero(u, [0 10000000]);
u0(i,j)=10*log10(u0(i,j));

    end
end
end