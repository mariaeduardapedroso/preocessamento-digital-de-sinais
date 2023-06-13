FILTRO FIR menos distorção
janelamento - > parece de tijolo: projetar um fltro ideal (imagina que é quadrado), resposta infinita e não causal. Truncamos a resposta da transformada de fourier inversa e aplicamos uma janela
%kaiserord -> acha ordem do filtro
%n: 
%Wn:
%beta: quao longe ta o filtro do ideal maior beta mais ideal
%ftype tipo do filtro

fs=1000
%fs: frequencia de amostragem
f=[110 200]
%f: vetor com limite de frequencias do filtro 
a=[1 0]
%a: amplitude de cada etapa do filtro (banda de passagem,banda de rejeição)
dev=[0.01 0.1]
%dev: desvio (diferente de atenuação), qual porcentagem de variação no
%ripple da banda de rejeição ou passagem, quanto % é desvio de a
[n,Wn,beta,ftype] = kaiserord(f, a,dev,fs)


escolher filtro
load sinais.mat

x = x3;
x_original = x2;

Ts = t(2)-t(1);
fs = 1/Ts;
%% Plotar no domínio do tempo

figure
hold all
plot(t,x,'k','LineWidth',1)
plot(t,x_original,'r','LineWidth',1.5)
xlabel('tempo (s)')
ylabel('Amplitude')
legend({'Sinal com ruído','Sinal sem ruído'})
grid on
ylim([-3 3])

%fir 1
%janela pode ser escolhida ou por padrão é hamming (w=window(@hamming,
%n+1))
%w: janela
w=window(@hamming, n+1)
b = fir1(n,Wn,ftype,w)

figure
subplot(2,1,1)
stem(w,'filled','k')
xlabel("n")
ylabel('w[n]')
subplot(2,1,2)
stem(b,'filled','r')
xlabel("n")
ylabel('b[n]')

%resposta do filtro
%fvtool(b,1)

%%janela faz diferença de fato


aplicando filtro
% x_filtrado = filter(w)

x_filtrado = conv(x,b,"same")
