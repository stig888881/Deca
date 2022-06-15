%clear all;

%Точка отражения
latitude = 56.84;    % Широта от -90 до 90, градусы
longitude = 53.78; % Долгота от -90 до 90, градусы
hour=4;                   %Время, часы
mounth = 8;             %Месяц
day = 8;                %День
year = 2017;            %Год
promnois=4;             %Уровень помех от 1 (деловая зона) до 4 (тихая сельская местность)

%Параметры линии
Pt=1;   %в кВт
Pt=10*log10(Pt);
G1=3;   %в разах коэффициент передающей антенны
Gt=10*log10(G1);
D2=2;   %в разах коэффициент приемной антенны
Dt=10*log10(D2);
B=300;  %Ширина канала в Гц
%bet=5*10^(-3);
betGr=5*10^(-3);%[10^(-3) 2.5*10^(-3) 5*10^(-3) 7.5*10^(-3) 10^(-2) 1.5*10^(-2) 2.5*10^(-2)];    %интенсивоность неоднородностей
bet=0.001:0.0005:0.05;
d=2000; %Дальность связи в км
sigmz=14;   %среднеквадратическое отклонение для расчета надежности связи


time = datenum([year mounth day hour 0 0]);

xj=[107.3 106.4 103.5 101 100 85.4 77.6 69.4 61.3 53.8 47.4 43.0 41.2 42.4 46.5 52.6 60.0 68.0 76.2 84.2 91.6 98.0 103.0 106.3 107.6]; %надо научиться расчитывать зенитный угол солнца
xjn=xj(13);
xj=xj(hour+1);

IRI=iri2016(time,latitude,longitude,300,false);

%Параметры ионосферы
f0F2=4;%IRI(:,28);     %Критическая частота слоя F2
f0E=IRI(:,30);      %Критическая частота слоя Е
M300F2=IRI(:,23);   %M-параметр при дальности связи 3000 км
R12=IRI(:,38);       %Число солнечных пятен
hm=IRI(:,15)*10^3;	%Высота максимума ионизации (м)

%Подготовка к расчетам

r=d*10^3;
hm=350000;
fcrF2=f0F2*10^6;

[f0,zdopGr]=FindZdop(fcrF2,r,hm,betGr);
[f0,zdop]=FindZdop(fcrF2,r,hm,bet);
[tmp,f08I]=min(abs(f0-f0(length(f0))*0.8));
[tmp1,f085I]=min(abs(f0-f0(length(f0))*0.85));
[tmp2,f09I]=min(abs(f0-f0(length(f0))*0.9));
clear tmp tmp1 tmp2;

f0=f0*10^(-6);
[Ec,Lb]=FindEc(R12,M300F2,f0,f0F2,f0E,xj,xjn,d);     %Построение напряженности сигнала на входе приемника
[Ep,FamT,Fatm,Fprom,Fsp]=FindEp(f0,f0F2,hour,promnois,B);               %Построение напряженности помехи

Ec=Ec+Gt+Pt;
Pr=Ec+Dt-20*log10(f0)-107.2;
SN=Pr-FamT-10*log10(B)+204;

for j=1:length(betGr)
    for i=1:length(SN)
        DsvGr(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdopGr(i,j))/sigmz)*0.5)+0.5;    %для графика
    end
end
for j=1:length(bet)
    for i=1:length(SN)
        Dsv(i,j)=0.5*erf(sqrt(2)*((SN(i)-zdop(i,j))/sigmz)*0.5)+0.5;    %в общем виде
    end
    Dsv08(j)=Dsv(f08I,j);
    Dsv085(j)=Dsv(f085I,j);
    Dsv09(j)=Dsv(f09I,j);
end


[zdopav,Izdopav]=min(abs(zdopGr-14));
[DsvGrmax,IGrmax]=max(DsvGr);
[DsvGrmin,IGrmin]=min(abs(DsvGr-0.8));
DsvGrmin=DsvGrmin+0.8;
Dsvmax=max(Dsv);


for i=1:length(IGrmax)
    textDsv(i,:)=strcat('{\itf}_{орч_',num2str(i),'}');
end



set(0,'DefaultAxesFontSize',12,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',12,'DefaultTextFontName','Times New Roman'); 

F2MUF=f0(length(f0));
a=1;    %начало по Х
b=F2MUF+0.5;    %конец по Х



c=-20;    %начало по У
d=150;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,Lb,'-','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.2,Lb(length(Lb)),'{\itL_b}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,Ec(length(Ec)),'{\itE}_{c}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,Ec,'-','Color',[.1 .1 .1],'LineWidth',1);
%text(F2MUF-0.1,c+3,'{\itf}_{м}','HorizontalAlignment','right', 'fontsize' ,14);
axis([a b c d]);  
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itE}_{c} , {\itL_b} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);




c=25;    %начало по У
d=70;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,Fatm,'--','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.2,Fatm(length(Fatm)),'{\itF}_{атм}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,Fprom(length(Fprom)),'{\itF}_{инд}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,Fsp(length(Fsp)),'{\itF}_{гал}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,FamT(length(FamT))+2,'{\itF_{amT}}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,Fprom,'-','Color',[.1 .1 .1],'LineWidth',1);
k=1;
for i=1:length(f0)
    if f0(i)>=f0F2;
        f0sp(k)=f0(i);
        Fsp1(k)=Fsp(i);
        k=k+1;
    end
end
semilogx(f0sp,Fsp1,'-.','Color',[.1 .1 .1],'LineWidth',1);
semilogx(f0,FamT,'-','Color',[.1 .1 .1],'LineWidth',1);
axis([a b c d]);
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itF_{amT}} , {\itF}_{атм} , {\itF}_{инд} , {\itF}_{гал} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);


c=-120;    %начало по У
d=80;    %конец по У


figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,Pr,'--','Color',[.1 .1 .1],'LineWidth',1);

text(b+0.2,Pr(length(f0)),'{\itP_r}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,FamT(length(f0))+10,'{\itF_{amT}}','HorizontalAlignment','left', 'fontsize' ,14);
text(b+0.2,SN(length(f0))-10,'$\overline{z}$','HorizontalAlignment','left','interpreter','latex', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,FamT,'-.','Color',[.1 .1 .1],'LineWidth',1);
semilogx(f0,SN,'-','Color',[.1 .1 .1],'LineWidth',1);
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
axis([a b c d]);   
%title('Рисунок 2');
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itP_r} , {\itF_{amT}} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);






c=5;    %начало по У
d=45;    %конец по У


figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,SN,'-','Color',[.1 .1 .1],'LineWidth',1);

text(b+0.2,SN(length(f0)),'$$\overline{z}$$','HorizontalAlignment','left','interpreter','latex', 'fontsize' ,14);
text(b+0.2,zdopGr(length(f0)),'{\itz}_{доп}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(f0,zdopGr,'-','Color',[.1 .1 .1],'LineWidth',1);
if (length(betGr)>1)
    text(f0(Izdopav(1))-0.03*f0(Izdopav(1)),13,num2str(1),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись графиков
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
for i=2:length(Izdopav)
    text(f0(Izdopav(i))-0.01*f0(Izdopav(i)),15,num2str(i),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись графиков
end
axis([a b c d]);   
%title('Рисунок 2');
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('z , z_{доп} , дБ','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);




c=0.75;    %начало по У
d=1;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(f0,DsvGr,'-','Color',[.1 .1 .1],'LineWidth',1);
line([a b], [0.8 0.8],'Color',[.1 .1 .1],'LineWidth',0.5, 'LineStyle','--');
line([F2MUF F2MUF], [c d],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
line([f0(IGrmin(1)) f0(IGrmin(1))], [c DsvGrmin(1)],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
text(F2MUF+0.1,0.77,'{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
text(f0(IGrmin(1))+0.01,0.77,'{\itf}_{н}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
for i=1:length(IGrmax)
    line([f0(IGrmax(i)) f0(IGrmax(i))], [0.75 DsvGrmax(i)],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');   
    if (length(betGr)>1)
        text(f0(IGrmax(i))+0.04*f0(IGrmax(i)),DsvGrmax(i)-0.005,num2str(i),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись графиков
        text(f0(IGrmax(i))-0.005*f0(IGrmax(i)),0.77,textDsv(i,:),'HorizontalAlignment','right', 'fontsize' ,14);      %Подпись орч
    else text(f0(IGrmax(i))-0.005*f0(IGrmax(i)),0.77,'{\itf}_{орч}','HorizontalAlignment','right', 'fontsize' ,14);      %Подпись орч
    end
    
end
text(F2MUF-0.1,c+3,'{\itf}_{м}','HorizontalAlignment','right', 'fontsize' ,14);
axis([a b c d]);  
if (length(betGr)>1)
    legend('Location','northwest','1. \beta=10^{-3}','2. \beta=2.5\cdot10^{-3}','3. \beta=5\cdot10^{-3}','4. \beta=7.5\cdot10^{-3}','5. \beta=10^{-2}','6. \beta=1.5\cdot10^{-2}','7. \beta=2.5\cdot10^{-2}','8. \beta=5\cdot10^{-2}');
end
set(gca,'xtick',[1 2 3 4 5 6 7 8 9 10 11 12]); 
set(gca,'xticklabel',{'1' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10' ; '11' ; '12'});
xlabel('{\itf_0 ,} МГц','Position',[b+0.2 c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itD}_{св}','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);


a=0.001;
b=0.05;
c=0.75;    %начало по У
d=1;    %конец по У

figure('position', [100, 100, 1000, 450],'Units', 'normalized');        %Полотно рисунка с размерами в параметре позиций
semilogx(bet,Dsvmax,'-','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsvmax(length(Dsvmax)),'{\itf}_{орч}','HorizontalAlignment','left', 'fontsize' ,14);
grid on;
hold on;
semilogx(bet,Dsv08,'--','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsv08(length(Dsv08))-0.005*Dsv08(length(Dsv08)),'0.8{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
semilogx(bet,Dsv085,'-.','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsv085(length(Dsv085)),'0.85{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
semilogx(bet,Dsv09,'-','Color',[.1 .1 .1],'LineWidth',1);
text(b+0.05*b,Dsv09(length(Dsv09))+0.005*Dsv09(length(Dsv09)),'0.9{\itf}_{м}','HorizontalAlignment','left', 'fontsize' ,14);
line([F2MUF F2MUF], [c d],'Color',[.1 .1 .1],'LineWidth',0.1, 'LineStyle','-.');
text(F2MUF-0.1,c+3,'{\itf}_{м}','HorizontalAlignment','right', 'fontsize' ,14);
axis([a b c d]);   
set(gca,'xtick',[0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.01 0.02 0.03 0.04 0.05]); 
set(gca,'xticklabel',{'10^{-3}' ; '2' ; '3' ; '4' ; '5' ; '6' ; '7' ; '8' ; '9' ; '10^{-2}' ; '2' ; '3' ; '4' ; '5\cdot10^{-2}'});
xlabel('\beta','Position',[b+0.15*b c -1],'FontWeight','bold','HorizontalAlignment','left', 'fontsize' ,14);                   %Подпись оси Х справа
ylabel('{\itD}_{св}','Position',[a d -1], 'Rotation', 0,'HorizontalAlignment','left','FontWeight','bold', 'fontsize' ,14);





