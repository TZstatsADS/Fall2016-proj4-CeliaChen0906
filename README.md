# Project: Words 4 Music

### [Project Description](doc/Project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**courseworks login required**)
+ [Data description](doc/readme.html)
+ Contributor's name: Chen Zheyuan
+ Projec title: 
+ Project summary: 
  ###Feature Selection:
  
   K-means is the main feature selection and standarization method I applied here. Here are music features I exacted and selected from the original dataset: 
   
    ####Bars: 
     I calculated the lagged difference of all bars_start(each bars' start time data) data for each song, then got the average mean of this value as every song's bars value. The reason behind this is, the bars help us capture whether the song is 2/4, 3/4 or 4/4, most songs' bar won't change or relatively stable across a song, that's why I chose to use mean value as the final value of this variable. This variable is important to define the genre of the song.
    
    ####Beats:
     Similar to Bars, the beats_start(time) itself is not that meaningful, but calculates the difference between the start times will illustrate the density of the beats, which is another useful indicator of the type of the music.
      
    ####Sections:
     Each song always includes many sections, the sections always repeat too. So the difference of sections start time capture the length of each section. If there're more than 3 sections, then I'll apply k means to reduce the dimension to 3. If not, I'll use the average length time of all sections.
      
    ####Loudness:
     The max loudness of each section is recorded here. To detect a few representative points of loudness of the song, I applied K means (k=5) to select the feature.
      
    ####MCFF:
     MCFF feature is one of the most important way to extract music feature, there're 12 variables to provide a comprehensive analysis of the song. I extracted the mean value of all sections for each variables.
    
    ####tantums:
     The tantums feature's average value.
    
    
   
  
   ###Model Selection: 
  
  OLS linear probability regression has been trained for each of 5000 key words, then estimate the probability of each of word's probability of 100 testing songs, then report a rank.
  
  But when the process of training model took me hours every time, and crashed R studio all the time.
	
Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
