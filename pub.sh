#!env sh
# 发布文档到站点

# 发布到目标服务器上的目录，请自己修改
TARGET_PATH=/root/docs/traffic_polling

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 本地build:'
gitbook build

# echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 修改html样式'
# echo '.summary>li:last-child{display:none}.book-header { position: fixed; /* background: white!important; */ width: 100%;}.book-header .btn {background-color: white;}.page-wrapper { padding-top: 50px;}' >>./_book/gitbook/style.css 
echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 尝试建立文档站点目录:'
ssh root@xr "mkdir $TARGET_PATH"
echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 清理站点上的老旧pdf'
ssh root@xr "rm $TARGET_PATH/*.pdf"

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 开始上传文件:'
if [ $1 == "-a" ]; then
	rsync -av -e ssh ./_book/* root@xr:$TARGET_PATH
	echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 覆盖所有文件成功'
else
	rsync -av -e ssh --exclude='gitbook/*' ./_book/* root@xr:$TARGET_PATH
	echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 覆盖文档内容成功'
fi
