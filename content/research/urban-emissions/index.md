---
title: "Predicting Ground Level Ozone Concentration from Urban Satellite and Street Level Imagery using Multimodal CNN"
authors:
- Nina Prakash
- admin
- Andrea Vallebueno
date: "2021-03-18T00:00:00"
doi: ""

# Schedule page publish date (NOT publication's date).
publishDate: "2021-03-18T00:00:00"

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["3"]

# Publication name and optional abbreviated publication name.
publication: "*Stanford CS230* final project"
publication_short: "*Stanford CS230* final project"

abstract: Understanding the impact of the built environment and urban populations on climate change and air quality is a growing challenge as the percentage of the world's population that resides in urban areas continues to rise. In particular, human activity levels have been shown to be directly linked with ground-level ozone, which is responsible for several health and climate effects. We explore this relationship through the use of a multimodal learning architecture that predicts ozone concentrations (parts per billion) in urban areas from satellite and street-level imagery. The model comprises two Convolutional Neural Networks (CNN), one trained on satellite images of each location to learn higher-level features such as geographical characteristics and land use, and another trained on multiple street-level images of each location to learn ground-level features such as motor vehicle activity. The feature representations learned from each sub-model are concatenated and passed through several fully connected layers to predict the ozone level of the location. This concatenated model achieves a test RMSE of 11.70 ppb. This approach can be used to inform urban planning and policy by providing an insight into the particular urban features that aggravate ozone concentrations.

# Summary. An optional shortened abstract.
summary: 

tags:
- Working Papers
- Machine Learning
featured: true

links:
url_pdf: http://cs230.stanford.edu/projects_winter_2021/reports/70701113.pdf
url_code: 'https://github.com/nicolas-suarez/urban_emissions'


---


This was our class project for Stanford CS230 "Deep Learning" class during the Winter 2021 quarter. The project was featured as one of the [Outstanding projects for the Winter 2021 quarter](https://cs230.stanford.edu/past-projects/#winter-2021). You can find our final report [here](http://cs230.stanford.edu/projects_winter_2021/reports/70701113.pdf).

## Description
This project examines the relationship between the level of ozone concentration
in urban locations and their physical features through the use of Convolutional
Neural Networks (CNNs). We train two models, including one trained on satellite
imagery ("Satellite CNN") to capture higher-level features such as the location's 
geography, and the other trained on street-level imagery ("Street CNN") to learn
ground-level features such as motor vehicle activity. These features are then 
concatenated to train neural network ("Concat NN") on this shared representation
 and predict the location's level of ozone as measured in parts per billion. 

## Data
We obtained ozone measurements (parts per billion) for 12,976 semi-unique locations with ozone levels information mostly located in North America from [AirNow](https://www.airnow.gov/).

Our satellite imagery dataset was constructed using the Google Earth Engine API: for each location labeled with an ozone reading, we retrieve one satellite image centered at that location from the Landsat 8 Surface Reflectance Tier 1 Collection with a resolution of 224 $\times$ 224 pixels which represents 6.72 km $\times$ 6.72 km.  We use 7 bands from this collection: RGB, ultra blue, near infrared, and two shortwave infrared bands. We preprocess each of our images by adding a cloud mask per pixel and then computing the per pixel and band mean composite of all the available images for the year 2020.

The street-level imagery dataset was constructed using the Google Maps Street View API. For each location labeled with an ozone level, we randomly sample 10 geospatial points within 6.72 km from the measurement point.

Here we can see some examples from our dataset:

{{< figure src="table1.jpg" align="center" >}}

## Network architecture
We train the two CNNs separately on the satellite and street-level imagery, both using a ResNet-18 architecture implemented in PyTorch and pretrained on the ImageNet dataset. The models are trained separately as the nature of the features they need to learn to associate with ozone concentration is quite different for each dataset. Transfer learning is used for both CNNs to leverage lower-level features learned on the ImageNet dataset. The ResNet-18 architecture was slightly adapted for our particular task; in the case of the satellite imagery, the CNN's input layer was modified to accommodate for the image's seven channels and was initialized using Kaiming initialization.

After training both CNNs separately to predict the ozone reading for each location, we extract 512 features for each satellite and each street image. These are concatenated to create a feature vector of size 1,024 representing the satellite image and a particular street view of a given location. We then train a Concatenated Feedforward Neural Network (NN) using these multiple representations of each location to predict the location's average ozone level in 2020. 

{{< figure src="architecture4.PNG" align="center" >}}

More details about regularization, the tuning process of hyperparameters and training of the network can be found in the report.

## Results
After tuning our hyperparameters and training our models, we obtain the following performance (Root Mean Square Error in our test set):


 |               | Satellite Model | Street-level Model | Concatenated Model |
 |:-------------:|:-------------:|:-------------:|:-------------:|
 |Test RMSE (ppb) | 12.48  |20.64 |11.70|

We can also visually compare our predictions for the test with ground truth values in the following figure:


{{< figure src="table4.jpg" align="center" >}}