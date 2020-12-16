setwd('/home/tom/Downloads/wdl_colombia/scrits_for_dane') # Set working directory to where you downloaded the replication folder
#install.packages("mclust")
library(mclust)

datapoints <- data.frame(scan("cnn_col_2018_annual_month_median_nl.csv",
                        what = list(avg_rad	 = 0,
                                    cf_cvg = 0,
                                    id = 0,
                                    lat = 0,
                                    long = 0
                                    ),
                        skip=1,
                        sep=",",
                        quiet=TRUE));

head(datapoints, 10);

avector_notnulled <- datapoints[,1] #avg_rad with negative values
#avector_nulled <- datapoints[,3] #avg_rad_nulled without neg values
class(avector_notnulled);

#avector_notnulled = exp(rnorm(1000))

#plot(avector_notnulled)



require(mclust)
head(avector_notnulled, 10);

fit=Mclust(avector_notnulled, G=3, model="V")

summary(fit)

fit$classification

#forplot = data.frame(d = avector_notnulled, classi = fit$classification, id = 1:length(avector_notnulled))

#require(ggplot2)
#ggplot(forplot, aes(x = id, y = d, col = factor(classi))) + geom_point()

      output <- data.frame(datapoints, bin_GMM = fit$classification)
    write.csv(output,'all_col_centroids_384_nl_bin_GMM_out_tomas.csv')
