hold on;
plot(xvals, solvals-1,'b','LineWidth',2);
plot(xvals, 0.0*solvals,'r--','LineWidth',2);
ax = gca;
ax.YLim = [-0.005, 0.03];
ax.XLim = [0.0,0.15];
xlabel('Quadrature parameter z','FontSize',14,'FontWeight','bold');
ylabel('Violation','FontSize',14,'FontWeight','bold');
hold off;
print('singletmatlab','-depsc')