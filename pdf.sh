#!env sh
# 生成pdf

if [ x$1 != x ]; then
	echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 生成pdf：'
	rm *.pdf
	gitbook pdf ./ ./.pre.pdf

	echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 压缩pdf:'
	compress-pdf .pre.pdf "解决方案$1.pdf"
	rm .pre.pdf

	echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 一切准备就绪，可以pub到站点了'
else
	echo "生成PDF，必须带有版本参数，Usage："
	echo "./pdf.sh V0.2"
	echo "./pdf.sh V2.3"
fi
