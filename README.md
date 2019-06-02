# table-update-tex
利用xtable输出到文件,在tex中利用input实现自动更新表格.



xtable:
https://cran.r-project.org/web/packages/xtable/index.html

修改表头格式:
https://stackoverflow.com/questions/15036754/r-package-xtable-how-to-create-a-latextable-with-multiple-rows-and-columns-from

使用方法:
修改R程序的输出目录到main.tex所在的目录,每次R中重新生成数据后,tex中重新编译即可更新表格.
