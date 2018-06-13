library(R.matlab)
library(ggplot2)
library(DDoutlier)
library(infotheo)
library(BBmisc)
library(pROC)
library(Rlof)
mat_to_matrix<-function(filename){
	data<-(R.matlab::readMat(filename))  # mat filecontain other information in form of list so if you want to know more about the file - try str(readmat(filename))
	return(data) 
}

outlier_scores<-function(data,n,k,norm=TRUE,type='equalfreq',file=""){
	X = data$X
	# print(X)
	Y = data$y
	# print(Y)
	after_norm <- X
	after_dis <- X
	if(norm){
		after_norm<-normalize(X, method = "standardize", range = c(0, 1), margin = 1L, on.constant = "quiet")
	}
	if(n!=0){
		after_dis<- discretize(after_norm, disc=type, nbins=NROW(after_norm)^(1/n) )
	}
	outlier.scores<-LOF(after_dis,k)
	score<-(outlier.scores)
	saveRDS(score,paste(paste("../bin/",file,sep=""),toString(n),toString(k),toString(norm),type,sep="_"))
    roc_obj = pROC::auc(Y,score)
    return (roc_obj)
}
get_value<-function(data,k,file){
	n_val <- c(0,2,4,6)
	output <- c()
	norm_val <-c(FALSE, TRUE)
	type_val<-c('equalfreq','equalwidth')
	for (type in type_val){
		for(norm in norm_val){
			for(n in n_val){
				auc <-outlier_scores(data,n,k,norm,type,file)
				output<-c(output,auc)
			}
		}
	}
	if(length(output)!=16){
		sprintf("Error in %s",k)
	}
	return(output)
}

percentage<-function(data){
	cnt_1 = length(data[data==1])
	p = cnt_1/length(data)*100
	return (p)
}
output<-data.frame(stringsAsFactors=FALSE)
folder<-"../data"
i<-0
files <- list.files(path=folder, pattern="*.mat", full.names=T, recursive=FALSE)
k_val <- c(10,30,50,100,200,300)
for(file in files){
	
	data<-mat_to_matrix(file)
	# data<-data[!duplicated(data), ]
	temp<-file
	temp<-substring(temp,3)
	temp<-strsplit(temp,'/')[[1]][3]
    temp<-gsub('.{4}$', '',temp)
	dim<-nrow(data$X)
	p = percentage(data$y)
	print(c(temp,p,dim))
	for(k in k_val){
		if(k>=nrow(data$X)){
			break
		}
		print(k)
		row <-get_value(data,k,temp)
		row<-as.list(c(temp,dim,p,k,row))
		output[i,]<-row
		i=i+1
	}
	saveRDS(output,paste("after_",temp,sep=""))	
}
write.csv(output,"../output/output.csv")
