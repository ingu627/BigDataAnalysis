# 군집분석 

# 데이터 탐색 
str(USArrests)
# 'data.frame':   50 obs. of  4 variables:
#  $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
#  $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
#  $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
#  $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...

head(USArrests)
#            Murder Assault UrbanPop Rape
# Alabama      13.2     236       58 21.2
# Alaska       10.0     263       48 44.5
# Arizona       8.1     294       80 31.0
# Arkansas      8.8     190       50 19.5
# California    9.0     276       91 40.6
# Colorado      7.9     204       78 38.7

summary(USArrests)
#      Murder          Assault         UrbanPop          Rape      
#  Min.   : 0.800   Min.   : 45.0   Min.   :32.00   Min.   : 7.30  
#  1st Qu.: 4.075   1st Qu.:109.0   1st Qu.:54.50   1st Qu.:15.07
#  Median : 7.250   Median :159.0   Median :66.00   Median :20.10
#  Mean   : 7.788   Mean   :170.8   Mean   :65.54   Mean   :21.23  
#  3rd Qu.:11.250   3rd Qu.:249.0   3rd Qu.:77.75   3rd Qu.:26.18  
#  Max.   :17.400   Max.   :337.0   Max.   :91.00   Max.   :46.00


# 유클리디안 거리 측정 

US.dist_euclidean = dist(USArrests, 'euclidean')
US.dist_euclidean
#                   Alabama     Alaska    Arizona   Arkansas California
# Alaska          37.177009
# Arizona         63.008333  46.592489
# Arkansas        46.928137  77.197409 108.851918
# California      55.524769  45.102217  23.194180  97.582017
# Colorado        41.932565  66.475935  90.351148  36.734861  73.197131
# Connecticut    128.206942 159.406556 185.159526  85.028289 169.277110
# Delaware        16.806249  45.182961  58.616380  53.010376  49.291480
# Florida        102.001618  79.974496  41.654532 148.735739  60.980735
# ...

# 분석 모형 구축(계층적 군집 분석)

US.single = hclust(US.dist_euclidean^2, method="single")
plot(US.single)

group = cutree(US.single, k=6)
group
#        Alabama         Alaska        Arizona       Arkansas     California 
#              1              2              1              3              1
#       Colorado    Connecticut       Delaware        Florida        Georgia 
#              3              4              1              5              3 
#         Hawaii          Idaho       Illinois        Indiana           Iowa
#              4              4              1              4              4 
#         Kansas       Kentucky      Louisiana          Maine       Maryland
#              4              4              1              4              1 
#  Massachusetts       Michigan      Minnesota    Mississippi       Missouri 
#              3              1              4              1              3
#        Montana       Nebraska         Nevada  New Hampshire     New Jersey 
#              4              4              1              4              3 
#     New Mexico       New York North Carolina   North Dakota           Ohio
#              1              1              6              4              4 
#       Oklahoma         Oregon   Pennsylvania   Rhode Island South Carolina
#              3              3              4              3              1
#   South Dakota      Tennessee          Texas           Utah        Vermont 
#              4              3              3              4              4 
#       Virginia     Washington  West Virginia      Wisconsin        Wyoming
#              3              3              4              4              3

rect.hclust(US.single, k=6)

# 비계층적 군집 분석 - k평균 군집 분석 

# install.packages('NbClust')
library(NbClust)
# install.packages('rattle')
library(rattle)
df=scale(wine[-1])
set.seed(1234)
fit.km = kmeans(df, 3, nstart=25)
fit.km$size
# [1] 62 65 51
fit.km$centers
#      Alcohol      Malic        Ash Alcalinity   Magnesium     Phenols
# 1  0.8328826 -0.3029551  0.3636801 -0.6084749  0.57596208  0.88274724
# 2 -0.9234669 -0.3929331 -0.4931257  0.1701220 -0.49032869 -0.07576891
# 3  0.1644436  0.8690954  0.1863726  0.5228924 -0.07526047 -0.97657548
#    Flavanoids Nonflavanoids Proanthocyanins      Color        Hue   Dilution
# 1  0.97506900   -0.56050853      0.57865427  0.1705823  0.4726504  0.7770551
# 2  0.02075402   -0.03343924      0.05810161 -0.8993770  0.4605046  0.2700025
# 3 -1.21182921    0.72402116     -0.77751312  0.9388902 -1.1615122 -1.2887761
#      Proline
# 1  1.1220202
# 2 -0.7517257
# 3 -0.4059428

# 분석 모형 활용
plot(df, col=fit.km$cluster)
points(
    fit.km$center, col=1:3, 
    pch=8, cex=1.5)


# 연관성 분석

# install.packages('arules')
# install.packages('arulesViz')

library(arules)
library(arulesViz)
data('Groceries')
summary(Groceries)

# transactions as itemMatrix in sparse format with
#  9835 rows (elements/itemsets/transactions) and
#  169 columns (items) and a density of 0.02609146

# most frequent items:
#       whole milk other vegetables       rolls/buns             soda
#             2513             1903             1809             1715 
#           yogurt          (Other)
#             1372            34055

# element (itemset/transaction) length distribution:
# sizes
#    1    2    3    4    5    6    7    8    9   10   11   12   13   14   15   16 
# 2159 1643 1299 1005  855  645  545  438  350  246  182  117   78   77   55   46 
#   17   18   19   20   21   22   23   24   26   27   28   29   32 
#   29   14   14    9   11    4    6    1    1    1    1    3    1

#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#   1.000   2.000   3.000   4.409   6.000  32.000

# includes extended item information - examples:
#        labels  level2           level1
# 1 frankfurter sausage meat and sausage
# 2     sausage sausage meat and sausage
# 3  liver loaf sausage meat and sausage

# apriori 함수를 통한 연관 규칙 생성 
apr = apriori(
    Groceries,
    parameter=list(support=0.01,
    confidence=0.3)
    )
# Apriori

# Parameter specification:
#  confidence minval smax arem  aval originalSupport maxtime support minlen
#         0.3    0.1    1 none FALSE            TRUE       5    0.01      1
#  maxlen target  ext
#      10  rules TRUE

# Algorithmic control:
#  filter tree heap memopt load sort verbose
#     0.1 TRUE TRUE  FALSE TRUE    2    TRUE

# Absolute minimum support count: 98

# set item appearances ...[0 item(s)] done [0.00s].
# set transactions ...[169 item(s), 9835 transaction(s)] done [0.01s].
# sorting and recoding items ... [88 item(s)] done [0.00s].
# creating transaction tree ... done [0.00s].
# checking subsets of size 1 2 3 4 done [0.01s].
# writing ... [125 rule(s)] done [0.00s].
# creating S4 object  ... done [0.00s].
# > 


# inspect 함수를 통해 연관 규칙 확인 

inspect(sort(apr, by='lift')[1:10])

#      lhs                                   rhs                support   
# [1]  {citrus fruit, other vegetables}   => {root vegetables}  0.01037112
# [2]  {tropical fruit, other vegetables} => {root vegetables}  0.01230300
# [3]  {beef}                             => {root vegetables}  0.01738688
# [4]  {citrus fruit, root vegetables}    => {other vegetables} 0.01037112
# [5]  {tropical fruit, root vegetables}  => {other vegetables} 0.01230300
# [6]  {other vegetables, whole milk}     => {root vegetables}  0.02318251
# [7]  {whole milk, curd}                 => {yogurt}           0.01006609
# [8]  {root vegetables, rolls/buns}      => {other vegetables} 0.01220132
# [9]  {root vegetables, yogurt}          => {other vegetables} 0.01291307
# [10] {tropical fruit, whole milk}       => {yogurt}           0.01514997
#      confidence coverage   lift     count
# [1]  0.3591549  0.02887646 3.295045 102
# [2]  0.3427762  0.03589222 3.144780 121  
# [3]  0.3313953  0.05246568 3.040367 171
# [4]  0.5862069  0.01769192 3.029608 102  
# [5]  0.5845411  0.02104728 3.020999 121
# [6]  0.3097826  0.07483477 2.842082 228
# [7]  0.3852140  0.02613116 2.761356  99
# [8]  0.5020921  0.02430097 2.594890 120  
# [9]  0.5000000  0.02582613 2.584078 127
# [10] 0.3581731  0.04229792 2.567516 149