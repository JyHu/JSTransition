
// OC调用JS的方法
function myJavascriptFunc(arg)
{
    // JS 调用OC，并有返回值，需要在OC中设置 myObjc_callback 这个方法的监听
    var a = myObjc_callback(arg);
    
    // 调用OC打印log
    LOG(a);
}