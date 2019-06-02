#https://stackoverflow.com/questions/15036754/r-package-xtable-how-to-create-a-latextable-with-multiple-rows-and-columns-from

dir ="/Users/wang/Desktop/excel-tex/"
setwd(dir)

library(xtable)

C = (rep(0:5,2))
n = rep(c(200,300),each=6)

data = matrix(runif(6*12),12,6)
data = round(data,3)
df =data.frame(c(replicate(6,"200"),replicate(6,"300")),C,cbind(data[,1:3],rep("",12),data[,4:6]))

# only needed if first column consists of numbers
df[[1]] <- as.character(df[[1]])

rle.lengths <- rle(df[[1]])$lengths
first <- !duplicated(df[[1]])
df[[1]][!first] <- ""

# define appearance of \multirow
df[[1]][first] <-
  paste0("\\multirow{", rle.lengths, "}{*}{{", df[[1]][first], "}}")




addtorow <- list()
addtorow$pos <- list(0, 0, 0)
addtorow$command <- c("\\multirow{2}*{$n$} &\\multirow{2}*{$C$}& \\multicolumn{3}{c}{The homoscedastic cases}&& \\multicolumn{3}{c}{The heteroscedastic cases} \\\\\n",
                      "	\\cline{3-5}     \\cline{7-9} ",
                      "&& $\\tau=0.25$ & $\\tau=0.5$ & $\\tau=0.75$ && $\\tau=0.25$ & $\\tau=0.5$ & $\\tau=0.75$ \\\\\n")
xtable(df,digits = c(0,0,0,rep(2,3),0,rep(2,3))
       ,caption = "测试"
       ,align = "cccccccccc"  # align and put a vertical line (first "l" again represents column of row numbers)
       ,label = "tab::test"
       ,hline.after=NULL, #We don't need hline; we use booktabs
       floating=TRUE # whether \begin{Table} should be created (TRUE) or not (FALSE)
) -> outtable

# cat(print(outtable,
#           hline.after = c(-1,2,nrow(outtable),nrow(outtable)-6),
#           booktabs = TRUE,
#           sanitize.text.function = force # Important to treat content of first column as latex function
#           ,add.to.row = addtorow,include.colnames = FALSE,include.rownames = FALSE)
#     ,file = "table.tex")

cat(print(outtable,
          hline.after = c(-1,0,nrow(outtable),nrow(outtable)-6),
          #booktabs = TRUE,
          sanitize.text.function = force # Important to treat content of first column as latex function
          ,caption.placement = "top" #"top", NULL

          ,add.to.row = addtorow,include.colnames = FALSE,include.rownames = FALSE)
    ,file = "table.tex")

