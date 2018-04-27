train_data=csvread('train.csv');
train_len=(size(train_data)(1))-1;

X_train=zeros(train_len,1);
Y_train=zeros(train_len,1);
X_train=train_data(2:train_len+1,1);
Y_train=train_data(2:train_len+1,2);


X_train_new=ones(train_len,2);
X_train_new(:,2)=X_train(:,1);

w=rand(2,1);

hold on;
scatter(transpose(X_train),transpose(Y_train));

X_dash=transpose(X_train_new)
plot(transpose(X_train),transpose(w)*X_dash,"g");

xlabel ("X");
ylabel ("Y");
title ("randomly initialised w");

print -dpdf "fig1.pdf";
close

w_dir=(inv(transpose(X_train_new)*X_train_new))*(transpose(X_train_new))*(Y_train);
hold on;
scatter(transpose(X_train),transpose(Y_train));

plot(transpose(X_train),transpose(w_dir)*X_dash,"g");

xlabel ("X");
ylabel ("Y");
title ("using w_direct");

print -dpdf "fig2.pdf";
close

hold on;
scatter(transpose(X_train),transpose(Y_train));
d=1;
for nepoch=1 : 2,
	for j=1 : 10000,
		new_X_dash=ones(2,1);
		new_X_dash(2,1)=X_train(j,1);
		mul=(0.00000001)*((((transpose(w))*new_X_dash)(1,1))-Y_train(j,1));
		w=w.-(mul*(new_X_dash));
		if mod(j, 100) == 0,
			hold on;
      		plot(transpose(X_train),transpose(w)*X_dash,"g");
   		end,	
	end,
end,
pause(10);
#xlabel ("X");
#ylabel ("Y");
#title ("intermidiate plots");
#print -dpdf "fig4.pdf";

close


hold on;
scatter(transpose(X_train),transpose(Y_train));
plot(transpose(X_train),transpose(w)*X_dash,"g");

xlabel ("X");
ylabel ("Y");
title ("Modified w");

print -dpdf "fig3.pdf";
close


test_data=csvread('test.csv');
test_len=(size(test_data)(1))-1;

X_test=zeros(test_len,1);
Y_test=zeros(test_len,1);
X_test=test_data(2:test_len+1,1);
Y_test=test_data(2:test_len+1,2);

X_test_new=ones(test_len,2);
X_test_new(:,2)=X_test(:,1);

Y_pred1=X_test_new*w;
Y_pred2=X_test_new*w_dir;

rmse1= sqrt(mean((Y_pred1 - Y_test).^2));
display(rmse1);
rmse2= sqrt(mean((Y_pred2 - Y_test).^2));
display(rmse2);