function left_pp(urlname){
uexWindow.onAnimationFinish=function()
{
	uexWindow.evaluateScript("root",0,"loadcon('"+urlname+"')");
}
var w=window.screen.width;
uexWindow.beginAnimition();
uexWindow.setAnimitionDelay('0');
uexWindow.setAnimitionDuration('300');
uexWindow.setAnimitionAutoReverse('0');
uexWindow.makeTranslation(-w,"0","0");
uexWindow.commitAnimition();
}

function right_pp(){
var w=window.screen.width;
uexWindow.beginAnimition();
uexWindow.setAnimitionDelay('0');
uexWindow.setAnimitionDuration('300');
uexWindow.setAnimitionAutoReverse('0');
uexWindow.makeTranslation(w,"0","0"); 
uexWindow.commitAnimition();
}