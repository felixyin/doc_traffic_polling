#!env sh
# 发布文档到站点

# 发布到目标服务器上的目录，请自己修改
TARGET_PATH=/root/docs/traffic_polling


echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 修改html样式'
echo '.summary>li:last-child{display:none}' >> ./_book/gitbook/style.css

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 尝试建立文档工程目录:'
ssh root@xr "mkdir $TARGET_PATH"
echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 清理老旧pdf'
ssh root@xr "rm $TARGET_PATH/*.pdf"

echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 开始上传文件:'
if [ $1 == "-all" ]; then
    rsync -av -e ssh ./_book/* root@xr:$TARGET_PATH
    echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 覆盖所有文件成功'
else 
    rsync -av -e ssh --exclude='gitbook/*' ./_book/* root@xr:$TARGET_PATH
    echo '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 覆盖文档内容成功'
fi


