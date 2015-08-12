var json_http_url="http://m.duudoo.com/json/";//json��������ַ
var wwwurl="http://m.duudoo.com/";//������


function isChinese(temp) 
{ 
var re = /[^\u4e00-\u9fa5]/; 
if(re.test(temp)) return false; 
return true; 
}