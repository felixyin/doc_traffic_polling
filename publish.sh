#!env sh
# 发布文档到服务器

# 修改样式
echo '.summary>li:last-child{display:none}' >> ./_book/gitbook/style.css

# 创建发布目录，需要自行修改
ssh root@xr "mkdir /root/website/website/collectedstatic/traffic_polling"

# 部署当前文档到发布目录，目录需要自行修改
#scp -r ./_book/*  root@xr:/root/website/website/collectedstatic/traffic_polling
rsync -av -e ssh --exclude='gitbook/*' ./_book/* root@xr:/root/website/website/collectedstatic/traffic_polling


