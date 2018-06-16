format long
%%
%Genereate Random input bits in M Levels (i.e.values from zero to M-1)
%M must be a power of 2
M=4;
L=5;
Number_Of_Samples=1000000;
WantNoise=1;
Signal=randi([0,M-1],1,Number_Of_Samples).*2-1; %Change to Biploar, too
%%
%%Choose Pulse Length and Upsample with Length L
%Instead of Upsampling and Convoluting, I chose each L ones to have a
%certain value from the Signal. For example, if L=4,M=4 and the signal is [-1,3]
%the Pulse_Convoluted_UpSampled= [-1 -1 -1 -1 3 3 3 3 ]
Pulse=ones(1,L)./sqrt(L); %Create as many pulses as Samples
Pulse_Convoluted_UpSampled=ones(1,Number_Of_Samples*L);
ctr=1;
for i=1:L:Number_Of_Samples*L-L+1
    for j=i:i+L
        Pulse_Convoluted_UpSampled(j)=Signal(ctr);
    end
    ctr=ctr+1;
end
Pulse_Convoluted_UpSampled=Pulse_Convoluted_UpSampled(1:Number_Of_Samples*L)./sqrt(L);
%To remove one excess item %Not so sure why it appears
%%
%Adding Noise
SignalToNoiseRatio=5;
if(WantNoise)
    Pulse_Convoluted_UpSampled=awgn(Pulse_Convoluted_UpSampled,SignalToNoiseRatio,'measured');
end

%%
%Matched_Filter
%Mf=fliplr(Pulse); %Would be done if not symmetrics Pulse (i.e. shifted around time-axis)
Mf=Pulse;
Result=conv(Pulse_Convoluted_UpSampled,Mf);
%%
%Get O/P
Output=zeros(1,Number_Of_Samples);
ExtraConLength=length(Result)-(Number_Of_Samples*L);
ctr2=1;
for(i=L:L:length(Result)-ExtraConLength)
    Output(ctr2)=Result(i);
    ctr2=ctr2+1;
end
%%
%Get Symbol Error Rate
NumberOfErrors=0;
for i=1:length(Output)
    if(abs(round(Output(i))-Signal(i))>1)
        NumberOfErrors=1+NumberOfErrors;
    end
end
format long 
ErrorRate=NumberOfErrors/Number_Of_Samples



