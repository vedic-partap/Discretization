# Effectiveness of Discretization on Outlier Detection #
## Intution and Idea ##
Using discretization techniques to get better result in anomoly detection algorithms. Disretization helps to reduce representational bias in algorithms. 
Neural nets also helps to reduce the same. 
## Dataset ##
[This Link](http://odds.cs.stonybrook.edu/) is a good colllection for outlier labeled data. 
## Experiments Done ##
 **LOF**
  1. Try different distance function
  2. Work on many dataset from UCI Machine Learning Repo.
  3. Results - Find works better on larger dataset than smaller one. 
  
 **OC SVM**
  1. Shift to linear Algorithm
  2. Test PCA, OC SVM 
  3. Results - Get better results than LOF
  
## Things To-Do ##
1. Do the mathematical formulation of OC SVM and PCA for Discetization. Ref. https://arxiv.org/pdf/1701.07114.pdf
2. Generate Synthetic dataset for One Class SVM and Test our hypothesis.
3. Work for Time Series dataset.

## Time Series Data ##
Temporal point data where each point has one or more attributes and the attributes change over time. Linear Method works pretty good for series data. 

For any doubts contact [Vedic Partap](http://cse.iitkgp.ac.in/~vedicp/). Feel free to mail at <vedicpartap1999@iitkgp.ac.in>. 
