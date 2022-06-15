function [Ec, Lb] = FindEc (R12,M300F2,f0,f0F2,f0E,xj,xjn,d)
R0=6371;    %Радиус Земли
AT=280;     %коэффициент поглащения волны в полдень в определенной широте в определенный месяц
p=1;      %Коэффициент дневного поглащения в определенной широте
Lh=2.5;






x=f0F2/f0E;
if x<2
    x=2;
end

y=x;
if y<1.8
    y=1.8;
end
deltM=0.18/(y-1.4)+0.096*(R12-25)/150;
H=1490/(M300F2+deltM)-316;


for i=1:length(f0)  %Цикл определения высоты отражения
    
    xr(i)=f0(i)/f0F2;
    if (x > 3.33) && (xr(i) >= 1)   %пункт a)

        if xr(i)<=3.7
            G=-2.102*xr(i)^4+19.5*xr(i)^3-63.15*xr(i)^2+90.47*xr(i)-44.73;
        else
            G=19.25;
        end
        ds=160+(H+43)*G;
        a=(d-ds)/(H+140);
        if xr(i)<=1.71
            F1=-1.862*xr(i)^4+12.95*xr(i)^3-32.03*xr(i)^2+33.5*xr(i)-10.91;
        else
            F1=1.21+0.2*xr(i);
        end
        E1=-0.09707*xr(i)^3+0.6870*xr(i)^2-0.7506*xr(i)+0.6;
        A1=140+(H-47)*E1;
        B1=150+(H-17)*F1-A1;
        if (a>=0) && (B1>=0)
            h=A1+B1*2.4^(-a);
        else
            h=A1+B1;
        end
        hr(i)=h;
        if hr(i)>800
            hr(i)=800;
        end    
        clear h;
    end
    
    if (x > 3.33) && (xr(i) < 1)   %пункт b)        
        if xr(i)>0.1
            Z=xr(i);
        else
            Z=0.1;
        end
        df=0.115*d/(Z*(H+140));
        if (df > 0.65)
            df=0.65;
        end
        b=-7.535*df^4+15.75*df^3-8.834*df^2-0.378*df+1;
        F2=0.645*Z^2+0.883*Z+0.162;
        E2=0.1906*Z^2+0.00583*Z+0.1936;
        A2=151+(H-47)*E2;
        B2=141+(H-24)*F2-A2;
        if B2>=0
            h=A2+B2*b;
        else
            h=A2+B2;
        end
        hr(i)=h;
        if hr(i)>800
            hr(i)=800;
        end    
        clear h;
    end
    
    if (x <= 3.33)   %пункт c)  
        U=8*10^(-5)*(H-80)*(1+11*y^(-2.2))+1.2*10^(-3)*H*y^(-3.6);
        J=-0.7126*y^3+5.863*y^2-16.13*y+16.07;
        hr(i)=115+H*J+U*d;
        if hr(i)>800
            hr(i)=800;
        end    
        clear h;
    end
    
    angle(i)=atan(cot(d/(2*R0))-R0/(R0+hr(i))*csc(d/(2*R0)));
    angled(i)=atand(cot(d/(2*R0))-R0/(R0+hr(i))*csc(d/(2*R0)));
    angleE(i)=asin((R0*cos(angle(i)))/(R0+hr(i)));
    angleEd(i)=asind((R0*cos(angle(i)))/(R0+hr(i)));
end


for i=1:length(f0)  %Цикл определения напряженности поля сигнала
    
    
    
    if xj>102
        xj=102;
    end
    if xjn>102
        xnj=102;
    end
    Fx=cosd(p*0.881*xj);
    if (Fx<0.002)
        Fx=0.002;          %Если брать как у них 0.02 - то влияние ионосферы ночью слишком велико, хотя так быть не должно
    end
    Fxn=cosd(p*0.881*xjn);
    if (Fxn<0.002)
        Fxn=0.002;
    end
    fL=0;%0.8;          %У них в программе так же
    Li(i)=(1+0.0067*R12)*sec(angleE(i))/(f0(i)+fL)^2*(AT*Fx/Fxn);
    
    dp(i)=2*R0*sin(d/(2*R0))/cos(angle(i)+d/(2*R0));          %Виртуальная наклонная дальность
    Lm=0;
    Lg=0;
    Lz=8.72;
    
    Lb(i)=32.45+20*log10(dp(i))+Li(i)+Lm+Lg+Lh+Lz;
    Ec(i)=141.6-Lb(i);      %не 136, а 141.6...тогда все получается как в МККР
    
end
tmp=150./sin(angle);
tmp2=dp-2.*tmp;
end