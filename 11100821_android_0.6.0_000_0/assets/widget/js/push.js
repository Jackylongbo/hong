function push(){
	//注册应用运行中Push事件通知函数
			uexWidget.setPushNotifyCallback("cbNotify");
			//注册获取硬件信息回调函数
			uexDevice.cbGetInfo = function(opCode, dataType, data){
				logger(data);//设备ID
			}
			//绑定当前用户信息到推送服务器
			setdeviceToken();
			//获取当前应用的DeviceToken
			uexDevice.getInfo('11');
			//注册获取Push消息内容的回调函数
			uexWidget.cbGetPushInfo = function(opCode, dataType, data){
				logger(data);//PUSH BODY
			}
			//获取应用由Push激活时的Push消息内容
			uexWidget.getPushInfo();
}



function setdeviceToken(){
	//绑定用户UID和用户昵称到AppCan后台服务器
	 uexWidget.setPushInfo("windeidolon","");
}


function cbNotify(){
	
	//logger("cbNotify");
	//当运行时收到Push消息后，获取Push消息内容
	uexWidget.getPushInfo();
}


function logger(s)
{
	alert(s);
}



function down_atta(fileurl,filename){
	if(fileurl==""){return false;}
	var inOpCode=1;
	uexDownloaderMgr.onStatus = function(opCode,fileSize,percent,status){
	switch (status) {
	case 0:
	//uexWindow.toast("1","5","下载进度："+percent+"%","1200");
	break;
	case 1:
	//uexWindow.toast("0","5","附件下载完成！","6000");
　　uexDownloaderMgr.closeDownloader(opCode);
　　break;
	case 2:
	//uexWindow.toast("0","5","下载失败！","3000");
	uexDownloaderMgr.closeDownloader(opCode);
	break;
	}
	}

	uexDownloaderMgr.cbCreateDownloader = function(opCode,dataType,data){
	if(data == 0){
	var softname=filename;
	wgtname="wgt://data/download/"+softname;
	uexDownloaderMgr.download(inOpCode,fileurl,
	wgtname,'0');
	}
	else
	{
		alert(" 创建下载失败，请确认当前下载进程未被占用或手机中有SD存储卡！");
	}
	}
	uexDownloaderMgr.createDownloader(inOpCode);	
}


function install(){
	uexWidget.installApp("wgt://data/soft.apk");
	}