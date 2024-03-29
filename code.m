% Command File
% Audio Steganography
 
global snd1;
global snd2;
 
snd1 = 'C:\Users\User\Downloads\a1.wav';    
snd2 = 'C:\Users\User\Desktop\signal.wav';
 
[y, fs] = audioread(snd1);
[y2, fs2] = audioread(snd2);
 
yleft=y(:,1);
 
y2left=y2(:,1);
 
figure(1)
specgram(yleft,256,fs);
 
figure(2)
specgram(y2left,256,fs);
 
[b1,a1]=butter(10,(5*fs/16)/(fs/2));
yfiltered=filter(b1,a1,yleft);
 
figure(3);
specgram(yfiltered,256,fs);
 

[b2a,a2a]=butter(10,((450)/(fs/2)),'high');
[b2b,a2b]=butter(10,((fs/16 + 450)/(fs/2)));
 
y2high=filter(b2a,a2a,y2left);
y2filtered=filter(b2b,a2b,y2high);
 

figure(4);
specgram(y2filtered,256,fs2);
 
 
t=[0:size(y2left,1)-1]/fs;
 
modulate=cos(2*pi*(7*fs/16-450)*t);
 
figure(5);
specgram(modulate,256,fs);
 
y2mod = y2filtered.*modulate';
 
figure(6);
specgram(y2mod,256,fs);
 
size1=size(yfiltered,1);
size2=size(y2mod,1);
 
if (size2<size1)
   y2mod = [y2mod' zeros(1,size1-size2)]';
else
   yfiltered = [yfiltered' zeros(1, size2-size1)]';
end
 
yhidden=yfiltered+y2mod;
 
figure(7);
specgram(yhidden, 256, fs);
  
 
[b3, a3] = butter(10, (3*fs/8)/(fs/2), 'high');
 
[b4, a4] = butter(10, ((fs/2.05)/(fs/2)));
 
yrechigh = filter(b3,a3,yhidden);

yrecmod = filter(b4,a4,rechigh);
 
figure(8);
specgram(yrecmod,256,fs);
 
size1=size(yrecmod,1);
size2=size(modulate,2);
 
if (size2<size1)
   modulate = [modulate zeros(1,size1-size2)];
else
   yrecmod = [yrecmod' zeros(1, size2-size1)]';
end
 
y2demod = yrecmod.*modulate';
 
figure(9);
specgram(y2demod, 256,fs);
 
[b5,a5]= butter(6,(fs/16)/(fs/2));
 
y2recovered=filter(b5,a5,y2demod);

figure(10);
specgram(y2recovered,256,fs);
