num_samples <- 50000
data <- rexp(num_samples, 0.2)
plot(seq(1,50000,1),data,xlab="x",ylab="rexp",main="Scatter plot for rexp data")

cat("Distribution mean- ",mean(data),"\n")
cat("Distribution sd- ",sd(data),"\n")

partitiondata <- list()
for(i in 1: 500){
	start =100*i-99
	end=100*i
	partitiondata[[i]] <- data[start:end]  
	
}

for(i in 1:5){
	plot(density(partitiondata[[i]]), xlab="X", ylab="f(X)",main=paste("PDF plot for partition ",i)) 
	plot(ecdf(partitiondata[[i]]), col="blue", xlab="X", ylab="F(X)" ,main=paste("CDF plot for partition ",i))

	cat("Mean for partition",i,"- ",mean(partitiondata[[i]]),"\n")
	cat("Std dv for partition",i,"- ",sd(partitiondata[[i]]),"\n")
}

means <- vector()
sds <- vector()
for(i in 1:500){
	means[i] <- mean(partitiondata[[i]])
	sds[i]<-sd(partitiondata[[i]])
}

#mean convergence
hist(means, xlab="Value", ylab="Frequency" ,col="darkmagenta",main="Freq plot for sampled mean values")
plot(density(means), xlab="X", ylab="f(X)" ,main="PDF plot for sampled mean values") 
plot(ecdf(means), col="blue", xlab="X", ylab="F(X)",main="CDF plot for sampled mean values")

print(mean(means))
print(sd(means))


