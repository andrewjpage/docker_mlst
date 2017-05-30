library(ggplot2)
all_data = read.table('coverage_results.tsv',header = TRUE, sep = "\t")

ggplot(data = all_data, aes(x = Coverage, y = Correct_alleles, group = Software, linetype=Software,shape = Software )) +geom_line()+geom_point()+
theme_classic() +
ylim(c(0,7))+
xlab("Coverage") +
ylab("No. of correct alleles")+
theme_bw(base_size = 16) +  theme(legend.justification=c(1,0),legend.position=c(0.95,0.05))+
ggsave(filename="coverage_correct_alleles.png", scale=1)

ggplot(data = all_data, aes(x = Coverage, y = Time, group = Software, linetype=Software,shape = Software )) +geom_line()+geom_point()+
theme_classic() +
xlab("Coverage") +
ylab("Running time(s)")+
theme_bw(base_size = 16) +  theme(legend.justification=c(0,1),legend.position=c(0.05,0.95))+
ggsave(filename="coverage_running_time.png", scale=1)


ggplot(data = all_data, aes(x = Coverage, y = Disk_space, group = Software, linetype=Software,shape = Software )) +geom_line()+geom_point()+
theme_classic() +
xlab("Coverage") +
ylab("Disk space (bytes)")+
scale_y_continuous(trans='log10')+
theme_bw(base_size = 16) +  theme(legend.justification=c(0,1),legend.position=c(0.75,0.8))+
ggsave(filename="coverage_disk_space.png", scale=1)
