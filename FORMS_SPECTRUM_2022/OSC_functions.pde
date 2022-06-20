void oscEvent(OscMessage theOscMessage) {
  
  if(theOscMessage.checkAddrPattern("/layer1")==true) {
      layer1Size = theOscMessage.get(0).intValue();
      if(layer1Size>0){
        for(int i=1;i<layer1Size+1;i++){
          layer1=theOscMessage.get(i).stringValue();
          layer1Array[i-1]=layer1;        
        }
        listlayer1full=true;  
      }
      else{
        listlayer1full=false; 
      }
  }
  
  if(theOscMessage.checkAddrPattern("/layer2")==true) {
      layer2Size = theOscMessage.get(0).intValue();
      if(layer2Size>0){
        for(int i=1;i<layer2Size+1;i++){
          layer2=theOscMessage.get(i).stringValue();
          layer2Array[i-1]=layer2;        
        }
        listlayer2full=true;  
      }
      else{
        listlayer2full=false; 
      }
  }
  
  if(theOscMessage.checkAddrPattern("/layer3")==true) {
      layer3Size = theOscMessage.get(0).intValue();
        if(layer3Size>0){
          for(int i=1;i<layer3Size+1;i++){
            layer3=theOscMessage.get(i).stringValue();
            layer3Array[i-1]=layer3;        
          }
          listlayer3full=true;   
      }
      else{
        listlayer3full=false; 
      }
  }
  

  if(theOscMessage.checkAddrPattern("/fx1")==true) {
      fx1Size = theOscMessage.get(0).intValue();
      if(fx1Size>0){
        for(int i=1;i<fx1Size+1;i++){
          fx1=theOscMessage.get(i).stringValue();
          fx1Array[i-1]=fx1;        
        }
        listfx1full=true;
      }
      else{
        listfx1full=false;
      }
  }
  
  if(theOscMessage.checkAddrPattern("/fx2")==true) {
      fx2Size = theOscMessage.get(0).intValue();
      if(fx2Size>0){
        for(int i=1;i<fx2Size+1;i++){
          fx2=theOscMessage.get(i).stringValue();
          fx2Array[i-1]=fx2;        
        }
        listfx2full=true;
        }
      else{
        listfx2full=false;
      }
  }
  
  if(theOscMessage.checkAddrPattern("/fx3")==true) {
      fx3Size = theOscMessage.get(0).intValue();
      if(fx3Size>0){
        for(int i=1;i<fx3Size+1;i++){
          fx3=theOscMessage.get(i).stringValue();
          fx3Array[i-1]=fx3;        
        }
        listfx3full=true;
      }
      else{
        listfx3full=false;
      }
  }
  
  if(theOscMessage.checkAddrPattern("/rootList")==true) {
      rootListSize = theOscMessage.get(0).intValue();
      if(rootListSize>0){
        for(int i=1;i<rootListSize+1;i++){
          thisRoot=theOscMessage.get(i).intValue();
          rootList[i-1]=thisRoot;        
        }
        //println(rootList);
      }    
  }
  
  if(theOscMessage.checkAddrPattern("/transposeList")==true) {
      transposeListSize = theOscMessage.get(0).intValue();
      if(transposeListSize>0){
        for(int i=1;i<transposeListSize+1;i++){
          thisTranspose=theOscMessage.get(i).intValue();
          transposeList[i-1]=thisTranspose;        
        }
        //println(transposeList);
      }    
  }
  
  if (theOscMessage.addrPattern().equals("/notegrid")) {
    notegrid = theOscMessage.get(0).intValue();
  }


  if (theOscMessage.addrPattern().equals("/paleta")) {
    paleta = theOscMessage.get(0).intValue();
  }

  if (theOscMessage.addrPattern().equals("/escala")) {
    selsc = theOscMessage.get(0).intValue();
  }

  if (theOscMessage.addrPattern().equals("/bars")) {
    bars = theOscMessage.get(0).intValue();
  }

  if (theOscMessage.isPlugged()==false) {
    if (theOscMessage.addrPattern().equals("/go")) {
      redraw();
    }
  }
}
