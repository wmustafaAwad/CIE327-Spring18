%%
L=4;
Number_Of_Samples=100000;
Pulse=ones(1,L)./sqrt(L); %Create as many pulses as Samples
Mf=fliplr(Pulse);
Output=zeros(1,Number_Of_Samples);
Pulse_Convoluted_UpSampled=ones(1,Number_Of_Samples*L);


%%Plotter
%%
M=2;
Signal=randi([0,M-1],1,Number_Of_Samples).*2-1;
ctr=1;
for i=1:L:Number_Of_Samples*L-L+1
    for j=i:i+L
        Pulse_Convoluted_UpSampled(j)=Signal(ctr);
    end
    ctr=ctr+1;
end
Pulse_Convoluted_UpSampled=Pulse_Convoluted_UpSampled(1:Number_Of_Samples*L)./sqrt(L);

CTR=1;

for SignalToNoiseRatio=1:0.25:20
    Noisy=awgn(Pulse_Convoluted_UpSampled,SignalToNoiseRatio,'measured');
    
    Result=conv(Noisy,Mf);
    ExtraConLength=length(Result)-(Number_Of_Samples*L);
    ctr2=1;
    for(i=L:L:length(Result)-ExtraConLength)
        Output(ctr2)=Result(i);
        ctr2=ctr2+1;
    end

    NumberOfErrors=0;
    for j=1:length(Output)
        if(abs(round(Output(j))-Signal(j))>1)
            NumberOfErrors=1+NumberOfErrors;
        end
    end
    ErrorRate2(CTR)=NumberOfErrors/Number_Of_Samples;
    CTR=CTR+1;
end


%%
M=4;

Signal=randi([0,M-1],1,Number_Of_Samples).*2-1;
ctr=1;
for i=1:L:Number_Of_Samples*L-L+1
    for j=i:i+L
        Pulse_Convoluted_UpSampled(j)=Signal(ctr);
    end
    ctr=ctr+1;
end
Pulse_Convoluted_UpSampled=Pulse_Convoluted_UpSampled(1:Number_Of_Samples*L)./sqrt(L);

CTR=1;

for SignalToNoiseRatio=1:0.25:20
    Noisy=awgn(Pulse_Convoluted_UpSampled,SignalToNoiseRatio,'measured');
    
    Result=conv(Noisy,Mf);
    ExtraConLength=length(Result)-(Number_Of_Samples*L);
    ctr2=1;
    for(i=L:L:length(Result)-ExtraConLength)
        Output(ctr2)=Result(i);
        ctr2=ctr2+1;
    end

    NumberOfErrors=0;
    for j=1:length(Output)
        if(abs(round(Output(j))-Signal(j))>1)
            NumberOfErrors=1+NumberOfErrors;
        end
    end
    ErrorRate4(CTR)=NumberOfErrors/Number_Of_Samples;
    CTR=CTR+1;
    
end


%%
M=8;
Signal=randi([0,M-1],1,Number_Of_Samples).*2-1;
ctr=1;
for i=1:L:Number_Of_Samples*L-L+1
    for j=i:i+L
        Pulse_Convoluted_UpSampled(j)=Signal(ctr);
    end
    ctr=ctr+1;
end
Pulse_Convoluted_UpSampled=Pulse_Convoluted_UpSampled(1:Number_Of_Samples*L)./sqrt(L);


CTR=1;
for SignalToNoiseRatio=1:0.25:20
    Noisy=awgn(Pulse_Convoluted_UpSampled,SignalToNoiseRatio,'measured');
    
    Result=conv(Noisy,Mf);
    ExtraConLength=length(Result)-(Number_Of_Samples*L);
    ctr2=1;
    for(i=L:L:length(Result)-ExtraConLength)
        Output(ctr2)=Result(i);
        ctr2=ctr2+1;
    end

    NumberOfErrors=0;
    for j=1:length(Output)
        if(abs(round(Output(j))-Signal(j))>1)
            NumberOfErrors=1+NumberOfErrors;
        end
    end
    
    ErrorRate8(CTR)=NumberOfErrors/Number_Of_Samples;
    CTR=CTR+1;
end

%%
M=16;
Signal=randi([0,M-1],1,Number_Of_Samples).*2-1;
ctr=1;
for i=1:L:Number_Of_Samples*L-L+1
    for j=i:i+L
        Pulse_Convoluted_UpSampled(j)=Signal(ctr);
    end
    ctr=ctr+1;
end
Pulse_Convoluted_UpSampled=Pulse_Convoluted_UpSampled(1:Number_Of_Samples*L)./sqrt(L);


CTR=1;
for SignalToNoiseRatio=1:0.25:20
    Noisy=awgn(Pulse_Convoluted_UpSampled,SignalToNoiseRatio,'measured');
    
    Result=conv(Noisy,Mf);
    ExtraConLength=length(Result)-(Number_Of_Samples*L);
    ctr2=1;
    for(i=L:L:length(Result)-ExtraConLength)
        Output(ctr2)=Result(i);
        ctr2=ctr2+1;
    end

    NumberOfErrors=0;
    for j=1:length(Output)
        if(abs(round(Output(j))-Signal(j))>1)
            NumberOfErrors=1+NumberOfErrors;
        end
    end
    ErrorRate16(CTR)=NumberOfErrors/Number_Of_Samples;
    CTR=CTR+1;
end


%%






semilogy(1:0.25:20,ErrorRate2,1:0.25:20,ErrorRate4,1:0.25:20,ErrorRate8,1:0.25:20,ErrorRate16);
legend('PAM-2','PAM-4','PAM-8','PAM-16');
xlabel('SNR (dB)');
    ylabel('SER')
