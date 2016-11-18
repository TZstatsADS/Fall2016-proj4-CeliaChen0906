# Project: Words 4 Music

### [Project Description](doc/Project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**courseworks login required**)
+ [Data description](doc/readme.html)
+ Contributor's name: Chen Zheyuan
+ Projec title: 
+ Project summary: 
 + Feature Selection:
  
  Mainly I applied K means clustering at the feature selection, the lagged difference of bars and beats, to capture the song is 4/4, 3/4, or 2/4; then MFCC features stored at segments are also really important, after taking the means, I got 12 elements of MFCC features of each song, and some other features including at the analysis part in H5 file.
  
  + Model Selection: 
  
  Then I applied OLS linear probability regression on each of 5000 key words, then estimate the probability of each of word's probability of 100 testing songs, then report a rank.
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
