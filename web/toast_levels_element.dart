
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_toast.dart';
import '../core/interfaces.dart';


@CustomTag("toast-levels-element")
class ToastLevelsElement extends PolymerElement implements MessageNotifier{

  PaperToast toastElement;
  
  ToastLevelsElement.created() : super.created(){
  }

  @override
  void attached() {
    super.attached();    
    toastElement= $['toast'];    
  }
 
  @override
  void error(String m){
    toastElement.classes.clear();
    toastElement.classes.add("error");
    _toast(m);
  }
  
  @override
  void warn(String m){
    toastElement.classes.clear();
    toastElement.classes.add("warn");
    _toast(m);
  }

  @override
  void info(String m){
    toastElement.classes.clear();
    toastElement.classes.add("info");
    _toast(m);
  }
  
  void _toast(String m){
    toastElement.text = m;
    toastElement.show();
  }
}