library(ggplot2)
all_data = read.table('mixed_st_calls.tsv',header = TRUE, sep = "\t")

all_data$Mix = all_data$Mix*2
ggplot(data = all_data, aes(y = Mix, x= Software, fill = ST))+  geom_tile( ) + 
theme_classic() + 
theme_bw(base_size = 16)  + 
xlab("Software")+ ylim(c(1,100))+  
ylab("% of ST 365 (S.Weltevreden)")+ 
coord_flip()+
scale_fill_discrete(name="Predicted ST") 
ggsave(filename="mixing_samples.png", scale=1)

