# Main Idea
<p align=justify> Use a high dimensional dataset for a more specific modelling of an unknown function. A neuro-fuzzy model is again trained and validated before its efficacy is finally checked. <br></p>
<p align=justify> The Superconductivity dataset is first divided in three subsets used for each one of the above-mentioned purposes and the results are evaluated using the criteria mentioned below. <br></p>
<p align = justify> Although the main idea shares the same theoretical background with the first part of the project, there are additional aspects to be taken into consideration.<br></p>
A TSK model creation becomes more difficult as the number of inputs increases and an unwanted phenomenon known as "rule explosion" may appear. In order to prevent this from happening, we first define a partition for k-fold cross-validation on certain observations and then we tune both the number of the inputs and the number of the rules using the Relief algorithm to decide the optimal features' selection<br></p>
<p align = justify> After the optimal parameters have been found, they are used to train the TSK model which is then evaluated with the metrics presented below.

# Dataset
The code uses the Superconductivity dataset which consists of 21263 samples and 81 features. It is available in the UCI Repository. 

# Evaluation Metrics 
- RMSE
- NMSE
- NDEI
- R<sup>2</sup>

These metrics have been implemented in the respetive files found in the main folder and need to be included in the same repository as the `part2` file for it to execute.
