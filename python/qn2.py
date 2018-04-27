import numpy as np 
import copy
import matplotlib.pyplot as plt
import math

csv = np.genfromtxt('train.csv',delimiter=",")

X_train = np.zeros(shape=(10000,1));
X_train[:,0]=copy.deepcopy(csv[1:10001,0]);


X_train_new = np.ones(shape=(10000,2));
X_train_new[:,1]=copy.deepcopy(X_train[:,0])

w=np.random.rand(2,1);

Y_train = np.zeros(shape=(10000,1));
Y_train[:,0]=copy.deepcopy(csv[1:10001,1]);

Xdash=np.zeros(shape=(2,10000));
Xdash[:,:]=copy.deepcopy(np.transpose(X_train_new));

product=np.zeros(shape=(1,10000))
product[:,:]=copy.deepcopy((np.transpose(w)).dot(Xdash));

x=np.zeros(shape=(1,10000))
x[:,:]=copy.deepcopy(np.transpose(X_train))
y=np.zeros(shape=(1,10000))
y[:,:]=copy.deepcopy(np.transpose(Y_train))


plt.plot((np.transpose(x)).reshape(10000,), (np.transpose(product)).reshape(10000,),'b')
plt.plot(x,y,'go')
plt.show()	

w_direct=np.zeros(shape=(2,1))
w_direct[:,:]=copy.deepcopy((np.linalg.inv(np.transpose(X_train_new).dot(X_train_new))).dot((np.transpose(X_train_new)).dot(Y_train)))

product2=np.zeros(shape=(1,10000))
product2[:,:]=copy.deepcopy((np.transpose(w_direct)).dot(Xdash))
plt.plot((np.transpose(x)).reshape(10000,), (np.transpose(product2)).reshape(10000,),'b')
plt.plot(x,y,'go')
plt.show()

for i in range(0,2):
	for j in range(0,10000):

		new_Xdash=np.ones(shape=(2,1))
		new_Xdash[1,0]=X_train[j,0]
		
		mul=(0.00000001)*((((np.transpose(w)).dot(new_Xdash))[0,0])-Y_train[j,0])
		
		w=w-(mul*(new_Xdash))

		if((j%100)==0):
			cal=np.ones(shape=(1,10000))
			cal[:,:]=(np.transpose(w)).dot(Xdash)
			plt.plot((np.transpose(x)).reshape(10000,),(np.transpose(cal)).reshape(10000,),'b')
			plt.plot(x,y,'go')
			plt.show()


cal=np.ones(shape=(1,10000))
cal[:,:]=(np.transpose(w)).dot(Xdash)
plt.plot((np.transpose(x)).reshape(10000,),(np.transpose(cal)).reshape(10000,),'b')
plt.plot(x,y,'go')
plt.show()

csv2 = np.genfromtxt('test.csv',delimiter=",")

X_test = np.zeros(shape=(1000,1))
X_test[:,0]=copy.deepcopy(csv2[1:1001,0])
Y_test = np.zeros(shape=(1000,1))
Y_test[:,0]=copy.deepcopy(csv2[1:1001,1])

X_test_new = np.ones(shape=(1000,2))
X_test_new[:,1]=copy.deepcopy(X_test[:,0])

y_pred1= np.zeros(shape=(1000,1))
y_pred1[:,:]=copy.deepcopy(X_test_new.dot(w))

y_pred2= np.zeros(shape=(1000,1))
y_pred2[:,:]=copy.deepcopy(X_test_new.dot(w_direct))

error1=0
for i in range(0,1000):
	error1=error1+((y_pred1[i,0]-Y_test[i,0])**2)
error1=(error1*1.000000/1000)
error1=(math.sqrt(error1));
print error1

error2=0
for i in range(0,1000):
	error2=error2+((y_pred2[i,0]-Y_test[i,0])**2)
error2=(error2*1.000000/1000)
error2=(math.sqrt(error2));
print error2

