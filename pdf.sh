#!env sh
# 发布文档到服务器

# 生成pdf
gitbook pdf ./ ./.pre.pdf
compress-pdf .pre.pdf 解决方案.pdf 
rm .pre.pdf
gitbook build

