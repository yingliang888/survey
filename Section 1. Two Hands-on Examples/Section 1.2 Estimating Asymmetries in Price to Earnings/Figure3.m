% Plot: 
figure
line1 = @(x) basu(1)+basu(2).*x + basu(3).*x.*(x<0);
lineub = @(x) basu_interval(1,2)+basu_interval(2,2).*x + basu_interval(3,2).*x.*(x<0);
linelb = @(x) basu_interval(1,1)+basu_interval(2,1).*x + basu_interval(3,1).*x.*(x<0);
hold on
fplot(line1,[min(ret),max(ret)],'linewidth',4)
fplot(linelb,[min(ret),max(ret)],'linewidth',2,'LineStyle','--' )
fplot(lineub,[min(ret),max(ret)],'linewidth',2,'LineStyle','--' )
hold off

%%%polyfit
ret2 = ret(~isnan(ret));
ear2 = ear(~isnan(ret));
ret3 = ret2(~isnan(ear2));
ear3 = ear2(~isnan(ear2));
[p,S] = polyfit(ret3,ear3,5);
figure
fplot(@(x)polyval(p,x),[min(ret),max(ret)],'linewidth',4)


EXP0=nanmean(RES)
STD0=nanstd(RES)
EXP=nanmean(RES2)';
STD=nanstd(RES2)';

hold on
plot(GRIDRET,EXP)
xlabel('Market Return') 
ylabel('Predicted Earnings') 
legend('Non-parametric fit of earnings on returns')
shade(GRIDRET,EXP-2*STD,'--b',GRIDRET,EXP+2*STD,'FillType',[1 2;2 1],'--b','FillAlpha',.2);
hold off
